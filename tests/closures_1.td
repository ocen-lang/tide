/// out: outside inside

def outer() {
    let x = "outside"
    def inner() {
        print(x)
        x = "inside"
    }
    def inner2() {
        print(x)
    }
    inner()
    return inner2
}
outer()()