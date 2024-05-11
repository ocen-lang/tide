/// out: 10

class Foo {

}

def bar() => 10

let x = Foo()
x.foo = bar

print(x.foo())

