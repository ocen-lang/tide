class Zoo {
    def init(this) {
        .aardvark = 1
        .baboon   = 1
        .cat      = 1
        .donkey   = 1
        .elephant = 1
        .fox      = 1
    }
    def ant(this) => .aardvark
    def banana(this) => .baboon
    def tuna(this) => .cat
    def hay(this) => .donkey
    def grass(this) => .elephant
    def mouse(this) => .fox
}

let zoo = Zoo()
let sum = 0
let start = clock()
while (sum < 100000000) {
    sum = (sum + zoo.ant()
            + zoo.banana()
            + zoo.tuna()
            + zoo.hay()
            + zoo.grass()
            + zoo.mouse())
}

print(clock() - start)
print(sum)