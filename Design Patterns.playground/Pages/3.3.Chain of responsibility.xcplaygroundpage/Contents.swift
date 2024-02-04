//: ## Example 1

protocol Withdrawing {
    func withdraw(amount: Int) -> Bool
}

final class MoneyPile: Withdrawing {

    let value: Int
    var quantity: Int
    var next: Withdrawing?

    init(value: Int, quantity: Int, next: Withdrawing?) {
        self.value = value
        self.quantity = quantity
        self.next = next
    }

    func withdraw(amount: Int) -> Bool {

        var amount = amount

        func canTakeSomeBill(want: Int) -> Bool {
            return (want / self.value) > 0
        }

        var quantity = self.quantity

        while canTakeSomeBill(want: amount) {

            if quantity == 0 {
                break
            }

            amount -= self.value
            quantity -= 1
        }

        guard amount > 0 else {
            return true
        }

        if let next {
            return next.withdraw(amount: amount)
        }

        return false
    }
}

final class ATM: Withdrawing {

    private var hundred: Withdrawing
    private var fifty: Withdrawing
    private var twenty: Withdrawing
    private var ten: Withdrawing

    private var startPile: Withdrawing {
        return self.hundred
    }

    init(hundred: Withdrawing,
           fifty: Withdrawing,
          twenty: Withdrawing,
             ten: Withdrawing) {

        self.hundred = hundred
        self.fifty = fifty
        self.twenty = twenty
        self.ten = ten
    }

    func withdraw(amount: Int) -> Bool {
        return startPile.withdraw(amount: amount)
    }
}

// Create piles of money and link them together 10 < 20 < 50 < 100.**
let ten = MoneyPile(value: 10, quantity: 6, next: nil)
let twenty = MoneyPile(value: 20, quantity: 2, next: ten)
let fifty = MoneyPile(value: 50, quantity: 2, next: twenty)
let hundred = MoneyPile(value: 100, quantity: 1, next: fifty)

// Build ATM.
var atm = ATM(hundred: hundred, fifty: fifty, twenty: twenty, ten: ten)
atm.withdraw(amount: 310) // Cannot because ATM has only 300
atm.withdraw(amount: 100) // Can withdraw - 1x100

//: ## Example 2
// Handler protocol: Defines the interface for handling requests
protocol Handler {
    var nextHandler: Handler? { get set }
    func handleRequest(request: Int)
}

// ConcreteHandler class: Handles requests it is responsible for, and forwards the rest to the next handler
class ConcreteHandler: Handler {
    var nextHandler: Handler?
    let threshold: Int

    init(threshold: Int) {
        self.threshold = threshold
    }

    func handleRequest(request: Int) {
        if request <= threshold {
            print("Request \(request) handled by ConcreteHandler with threshold \(threshold)")
        } else {
            // If there's a next handler, forward the request
            nextHandler?.handleRequest(request: request)
        }
    }
}

// Client code
let handler1 = ConcreteHandler(threshold: 10)
let handler2 = ConcreteHandler(threshold: 20)
let handler3 = ConcreteHandler(threshold: 30)

// Create the chain of responsibility
handler1.nextHandler = handler2
handler2.nextHandler = handler3

// Send requests through the chain
handler1.handleRequest(request: 5)
handler1.handleRequest(request: 15)
handler1.handleRequest(request: 25)
