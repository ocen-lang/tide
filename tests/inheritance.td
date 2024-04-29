/// out: a 0 b 0 a 1 c 1

class Foo {
    def init(this, name) {
        .name = name
    }

    def a(this) {
        print("a " + .name)
    }

    def b(this) {
        print("b " + .name)
    }
}

class Bar extends Foo {
    def b(this) {
        print("c " + .name)
    }
}

let a = Foo("0")
a.a()
a.b()

let b = Bar("1")
b.a()
b.b()
