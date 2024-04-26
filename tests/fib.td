/// out: 0 1 1 2 3 5 8 13 21

let a = 0
let temp = 0

for let b = 1; a < 30; b = temp + b {
  print(a)
  temp = a
  a = b
}