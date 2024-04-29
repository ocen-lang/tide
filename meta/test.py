#!/usr/bin/env python3
import shutil
import os
import re
from subprocess import run, PIPE
import argparse
from ast import literal_eval
from dataclasses import dataclass
from enum import Enum
from os import system, makedirs
from pathlib import Path
from sys import argv
from typing import Union, Optional, Tuple
import multiprocessing
import sys
import textwrap

class Result(Enum):
    EXIT_WITH_OUTPUT = 1
    FAIL = 2
    SKIP_SILENTLY = 3
    SKIP_REPORT = 4


@dataclass(frozen=True)
class Expected:
    type: Result
    value: Union[int, str, None]


def get_expected(filename) -> Optional[Expected]:
    with open(filename, encoding="utf8", errors='ignore') as file:
        for line in file:
            if not line.startswith("///"):
                break

            line = line[3:].strip()

            # Commands with no arguments
            if line == "skip":
                return Expected(Result.SKIP_SILENTLY, None)
            if line == "":
                continue

            if ":" not in line:
                print(f'[-] Invalid parameters in {filename}: "{line}"')
                break

            # Commands with arguments
            name, value = map(str.strip, line.split(":", 1))

            if name == "out":
                return Expected(Result.EXIT_WITH_OUTPUT, value)
            if name == "fail":
                return Expected(Result.FAIL, value)

            print(f'[-] Invalid parameter in {filename}: {line}')
            break

    return Expected(Result.SKIP_REPORT, None)

def handle_test(interpreter: str, num: int, path: Path, expected: Expected) -> Tuple[bool, str, Path]:
    process = run(
        [interpreter, str(path), "--gc-stress"],
        stdout=PIPE,
        stderr=PIPE
    )

    if expected.type == Result.FAIL:
        if process.returncode == 0:
            return False, "Expected compilation failure, but succeeded", path

        error = process.stdout.decode("utf-8").strip()
        expected_error = expected.value

        if expected_error in error:
            return True, "(Success)", path
        else:
            try:
                remaining = error.split("Error: ")[1]
            except IndexError:
                remaining = error
            return False, f"Did not find expected error message\n  expected: {expected_error}\n  got: '{remaining}'", path

    elif process.returncode != 0:
        stdout = textwrap.indent(process.stdout.decode("utf-8"), " "*10).strip()
        stderr = textwrap.indent(process.stderr.decode("utf-8"), " "*10).strip()
        return False, f"Failed:\n  code: {process.returncode}\n  stdout: {stdout}\n  stderr: {stderr}", path

    assert expected.type == Result.EXIT_WITH_OUTPUT
    output = process.stdout.decode('utf-8').strip()
    output = re.sub(r"[\s\r\n]+", " ", output)
    expected_out = expected.value

    if expected_out not in output:
        return False, f'Incorrect output produced\n  expected: {repr(expected_out)}\n  got: {repr(output)}', path

    allocated_objects = re.search(r'\[GC\]\s*Allocated objects: (\d+)', output)
    if not allocated_objects:
        return False, "GC stats: allocated objects not found found", path
    freed_objects = re.search(r'\[GC\]\s*Freed objects: (\d+)', output)
    if not freed_objects:
        return False, "GC stats: freed objects not found found", path
    if int(allocated_objects.group(1)) != int(freed_objects.group(1)):
        return False, "GC stats: allocated and freed objects do not match", path

    return True, "(Success)", path

def pool_helper(args):
    return handle_test(*args)

def main():
    parser = argparse.ArgumentParser(description="Runs tide test suite")
    parser.add_argument(
        "-d",
        "--debug",
        action="store_true",
        help="Debug mode"
    )
    parser.add_argument(
        "files",
        nargs="?",
        default=["tests"],
        help="Files / folders to run"
    )

    interpreter = "./tide"
    run(["ocen", "compiler/main.oc", "-o", interpreter])

    args = parser.parse_args()
    arg_files = args.files if isinstance(args.files, list) else [args.files]
    test_paths = [Path(pth) for pth in arg_files]

    tests_to_run = []
    for path in test_paths:
        files = []

        if path.is_dir():
            for path_ in path.glob('**/*'):
                if path_.is_file():
                    files.append(path_)
        else:
            files.append(path)

        for file in files:
            expected = get_expected(file)
            if expected.type == Result.SKIP_SILENTLY:
                continue
            if expected.type == Result.SKIP_REPORT:
                print(f'[-] Skipping {file}')
                continue
            tests_to_run.append((file, expected))

    tests_to_run.sort()
    num_passed = 0
    num_failed = 0
    num_total = len(tests_to_run)

    arguments = [
        (interpreter, num, test_path, expected)
        for num, (test_path, expected) in enumerate(tests_to_run)
    ]

    def log_result(passed, message, path):
        nonlocal num_passed, num_failed, num_total
        if sys.stdout.isatty() and not args.debug:
            print(f" \33[2K[\033[92m{num_passed:3d}\033[0m", end="")
            print(f"/\033[91m{num_failed:3d}\033[0m]", end="")
            print(f" Running tests, finished {num_passed+num_failed} / {num_total}\r", end="", flush=True)
        else:
            print(f" Running tests, finished {num_passed+num_failed} / {num_total}", flush=True)
        if passed:
            num_passed += 1
        else:
            num_failed += 1
            if sys.stdout.isatty():
                print(f"\33[2K\033[91m[-] Failed {path}\033[0m")
                print(f"  - {message}", flush=True)
            else:
                print(f"[-] Failed {path}")
        if args.debug and not passed:
            exit(1)


    if args.debug:
        for inp in arguments:
            print(inp)
            passed, message, path = pool_helper(inp)
            log_result(passed, message, path)

    else:
        with multiprocessing.Pool(multiprocessing.cpu_count()) as pool:
            for passed, message, path in pool.imap_unordered(pool_helper, arguments):
                log_result(passed, message, path)

    if sys.stdout.isatty():
        print("\33[2K")
        print(f"Tests passed: \033[92m{num_passed}\033[0m")
        print(f"Tests failed: \033[91m{num_failed}\033[0m")
    else:
        print(f"Tests passed: {num_passed} / {num_total}")

    if num_failed > 0:
        exit(1)


if __name__ == "__main__":
    main()
