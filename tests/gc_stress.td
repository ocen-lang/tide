/// out: OK DONE

let runs = 5
let x = "1234"
for let i = 0; i < 5; i = i + 1 {
    x = x + x
}

for let i = 0; i < 10000; i = i + 1 {
    x = x + "hello"
}
print("OK DONE")