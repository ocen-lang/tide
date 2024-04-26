/// out: BAZ 12345

def baz() {
    print("BAZ")
    let b = "4"
    return b + "5"
}

def bar() {
    let b = "3"
    return "2" + b + baz()
}

print("1" + bar())