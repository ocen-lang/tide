/// skip
// This test takes a while, mostly used for benchmarking

def fib(n) {
  if (n < 2) return n
  return fib(n - 2) + fib(n - 1)
}

let start = clock()
print(fib(35))
print(clock() - start)