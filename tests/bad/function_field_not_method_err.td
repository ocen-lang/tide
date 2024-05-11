/// fail: Function bar expected 1 arguments, got 0

class Foo {

}

def bar(this) => 10

let x = Foo()
x.foo = bar

print(x.foo())
