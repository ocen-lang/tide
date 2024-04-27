/// out: outer inner value

def outer() {
    let x = "value"
    def middle() {
        def inner() {
            print(x)
        }
    
      print("inner")
      return inner
    }
  
    print("outer")
    return middle
}
  
let mid = outer()
let in = mid()
in()
  