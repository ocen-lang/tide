/// out: 100 200

def foo(x) {
    def bar() {
        print(x)
    }
    return bar
}

foo(100)()
foo(200)()