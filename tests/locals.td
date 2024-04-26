/// out: 60 30 10

let a = 10
{
    let b = 20
    let c = a + b
    {
        let d = a + b + c
        print(d)
    }
    print(c)
}
print(a)