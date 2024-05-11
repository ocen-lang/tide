/// out: 9

class Foo {
    def b(this) => 6
}

class Bar extends Foo {
    def b(this) => super.b() + 3
}

let b = Bar()
print(b.b())

