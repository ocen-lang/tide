/// skip
/// out: a 1 b 1 c 1

class Foo {
    def b(this) => 6
}

class Bar extends Foo {
    def b(this) {
        super.b()
    }
}

let b = Bar()
b.b()

