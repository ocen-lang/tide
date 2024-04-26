// Does not work currently

def foo() {
    print("Hello in foo")
}

print("Hello before foo")
print(foo())
print("Hello after foo")

def baz() {
    let b = "baz"
    print("in " + b)
    return "boo"
}

def bar() {
    let b = "bar"
    print("in " + b)
    return "kk" + baz()
}

print("aa" + bar())