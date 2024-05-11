/// out: 5

class Foo {
    def init(this, x) {
        .x = x
    }
}
Foo.val = 1
let x = Foo(4)

def m(t) => Foo.val + t.x
Foo.foo = m

print(x.foo())