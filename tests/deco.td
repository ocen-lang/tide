/// out: add 1 2 3 lol 1 2 null

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

@deco("lol")
@deco("add")
def add(a, b) {
    return a + b
}

add(1, 2)