/// out: before foo 1 2 after

def method_deco(func) {
    def wrapper(this, a, b) {
        print("before")
        let res = func(this, a, b)
        print("after")
        return res
    }
    return wrapper
}


class Foo {
    @method_deco
    def foo(this, a, b) {
        print("foo", a, b)
    }
}

let f = Foo()
f.foo(1, 2)