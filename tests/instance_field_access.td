/// out: 10 hello

class Foo {}
let x = Foo()
x.bar = 10
x.baz = "hello"
print(x.bar, x.baz)