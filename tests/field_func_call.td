/// out: not a method

// Makes sure we haven't broken this case with the
// INVOKE opcode.

class Oops {
    def init(this) {
        def f() {
            print("not a method")
        }

        this.field = f
    }
}

let oops = Oops()
oops.field()