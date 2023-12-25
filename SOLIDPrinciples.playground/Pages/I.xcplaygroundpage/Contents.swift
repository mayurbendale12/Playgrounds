import Foundation

protocol Worker {
    func eat()
    func work()
}

class Human: Worker {
    func eat() {
        print("eating")
    }

    func work() {
        print("working")
    }
}

class Robot: Worker {
    func eat() {
        // Robots can't eat!, Violation of this principle
        fatalError("Robots does not eat!")
    }

    func work() {
        print("working")
    }
}

//To solve this
protocol Feedable {
    func eat()
}

protocol Workable {
    func work()
}

class Human1: Feedable, Workable {
    func eat() {
        print("eating")
    }

    func work() {
        print("working")
    }
}

class Robot1: Workable {
    func work() {
        print("working")
    }
}
