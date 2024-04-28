/// out: <instance Foo> 5 8

class Foo {
    def bar(this) => .x = 5
    def test(this, a, b) => .x + a + b
}

let f = Foo()
print(f)
print(f.bar())
print(f.test(1, 2))