/// out: 1 2 3

def foo() {
    foo.count = foo.count + 1
    return foo.count
}
foo.count = 0

print(foo())
print(foo())
print(foo())