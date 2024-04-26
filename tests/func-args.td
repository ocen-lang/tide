/// out: 01234

def baz(a, b) => a + b + "3"

def bar(f) {
    let d = "4"
    return baz("1", f) + d
}

print("0" + bar("2"))
