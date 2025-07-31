//: [Previous](@previous)
import SwiftUI
/*: ## Freestanding Macros */
func myFunction() {
    print("Currently running \(#function)")
    #warning("Something's wrong")
}

myFunction()
/*: ## Attached Macros */
@Observable
class Counter {
    var value: Int = 0
}
//: [Next](@next)
