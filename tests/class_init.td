/// out: Person: John 30 JohnJohnJohn

class Person {
    def init(this, name, age) {
        .name = name
        .age = age
    }

    def print(this) {
        print("Person: " + .name, .age)
    }
    def bar(this) => .name + .name + .name
}


// let name = "ao"
// for let i = 0; i < 1000; i = i + 1 {
//     let person = Person(name, 30)
//     person.bar()
//     name = name + "tmp"
// }
let person = Person("John", 30)
person.print()
print(person.bar())
