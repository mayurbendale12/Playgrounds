import UIKit

//Class
class Person {
    //Properties
    var age: Int
    var gender: String
    var color: String
    var maritialStatus: String

    init(age: Int, gender: String, color: String, maritialStatus: String) {
        self.age = age
        self.gender = gender
        self.color = color
        self.maritialStatus = maritialStatus
    }

    //Functions
    func play(sport: String) {

    }

    //Method overloading
    func play(instrument: String) {

    }
}

class Men: Person {
    //Method overriding
    override func play(sport: String) {

    }
}

//Object
let man = Person(age: 30, gender: "Male", color: "White", maritialStatus: "M")
