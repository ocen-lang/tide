/// out: 10

class Foo {
    def init(this, x) => .x = x
    def bar(this) => .x
}

let x = Foo(10)
let y = x.bar
print(y())