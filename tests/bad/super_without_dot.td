/// fail: Expected `.` after `super`

class Foo {}
class Bar extends Foo {
    def bar(this) {
        super
    }
}