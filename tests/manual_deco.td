/// out: add 1 2 3

def deco(x) {
    def wrapper(func) {
        def inner(a, b) {
            let res = func(a, b)
            print(x, a, b, res)
        }
        return inner
    }
    return wrapper
}

def add(a, b) {
    return a + b
}
add = deco("add")(add)

add(1, 2)