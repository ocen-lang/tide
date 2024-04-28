/// out: OK

class Foo {
    def init(this) {
        .name = "foo"
    }
    def bar(this) => .name + "hello"
}

let foo = Foo()

let start = clock()

for let i = 0; i < 10; i = i + 1 {
    for let i = 0; i < 10000; i = i + 1 {
        foo.bar()
    }
}

let end = clock()
print("Took", end-start, "seconds")
print("OK")
