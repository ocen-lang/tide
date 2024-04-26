/// out: hello false false false true false true true true

let f = true
let g = false

if f {
    print("hello")
} else {
    print("bye")
}

print(g and g, g and f, f and g, f and f)
print(g or g, g or f, f or g, f or f)
