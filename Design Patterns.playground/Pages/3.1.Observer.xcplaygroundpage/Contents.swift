//: ## Example 1
protocol PropertyObserver: AnyObject {
    func willChange(propertyName: String, newPropertyValue: Any?)
    func didChange(propertyName: String, oldPropertyValue: Any?)
}

final class TestChambers {
    weak var observer: PropertyObserver?

    private let testChamberNumberName = "testChamberNumber"

    var testChamberNumber: Int = 0 {
        willSet(newValue) {
            observer?.willChange(propertyName: testChamberNumberName, newPropertyValue: newValue)
        }
        didSet {
            observer?.didChange(propertyName: testChamberNumberName, oldPropertyValue: oldValue)
        }
    }
}

final class Observer: PropertyObserver {
    func willChange(propertyName: String, newPropertyValue: Any?) {
        if newPropertyValue as? Int == 1 {
            print("Okay. Look. We both said a lot of things that you're going to regret.")
        }
    }

    func didChange(propertyName: String, oldPropertyValue: Any?) {
        if oldPropertyValue as? Int == 0 {
            print("Sorry about the mess. I've really let the place go since you killed me.")
        }
    }
}

var observerInstance = Observer()
var testChambers = TestChambers()
testChambers.observer = observerInstance
testChambers.testChamberNumber += 1

//: ## Example 2
// Protocol representing the observer
protocol Observer1: AnyObject {
    func update(data: String)
}

// Concrete implementation of the observer
class ConcreteObserver: Observer1 {
    var observerName: String

    init(name: String) {
        self.observerName = name
    }

    func update(data: String) {
        print("\(observerName) received update with data: \(data)")
    }
}

// Subject class that maintains a list of observers and notifies them of changes
class Subject {
    private var observers = [Observer1]()

    func addObserver(_ observer: Observer1) {
        observers.append(observer)
    }

    func removeObserver(_ observer: Observer1) {
        observers = observers.filter { $0 !== observer }
    }

    func notifyObservers(data: String) {
        for observer in observers {
            observer.update(data: data)
        }
    }
}

// Client code
let subject = Subject()

let observer1 = ConcreteObserver(name: "Observer 1")
let observer2 = ConcreteObserver(name: "Observer 2")

subject.addObserver(observer1)
subject.addObserver(observer2)

subject.notifyObservers(data: "Some data has changed!")
