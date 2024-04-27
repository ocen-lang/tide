/// out: updated

// shamelessly stolen from lox

let globalSet
let globalGet

def main() {
    let a = "initial"

    def set() { a = "updated" }
    def get() { print(a) }

    globalSet = set
    globalGet = get
}

main()
globalSet()
globalGet()