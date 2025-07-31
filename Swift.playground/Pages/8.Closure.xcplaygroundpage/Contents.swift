//: [Previous](@previous)
import UIKit

//Trailing closure
func someFunctionThatTakesAClosure(closure: () -> Void) {
}

// Here's how you call this function without using a trailing closure:
someFunctionThatTakesAClosure(closure: {
})

// Here's how you call this function with a trailing closure instead:
someFunctionThatTakesAClosure() {
}

//Multiple closure, omit the argument label for the first trailing closure and label the remaining trailing closures.
func loadPicture(from server: String, completion: (UIImage) -> Void, onFailure: () -> Void) {
    //download from server if it success
    completion(UIImage())

    //If it fails
    onFailure()

}

loadPicture(from: "Server") { image in

} onFailure: {

}

//Capturing values
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()

//Escaping closure
var completionHandlers: [() -> Void] = []
@MainActor
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

//non escaping closure
func someFunctionWithNonescapingClosure(completionHandler: () -> Void) {
    completionHandler()
}

//Capturing self
@MainActor class SomeOtherClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

//Without autoclosure
func sample(customer customerProvider: () -> String) {
}

sample {
    return ""
}

//With autoclosure
func serve(customer customerProvider: @autoclosure () -> String) {
}

serve(customer: "Sample")

//with autoclosure and escaping combine
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
var customerProviders: [() -> String] = []

@MainActor func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}

collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
//: [Next](@next)
