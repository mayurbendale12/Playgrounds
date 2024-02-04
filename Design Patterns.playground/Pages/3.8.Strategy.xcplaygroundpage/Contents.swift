// Strategy protocol: Defines the interface for the algorithms
protocol PaymentStrategy {
    func pay(amount: Double)
}

// ConcreteStrategy classes: Implement specific algorithms
class CreditCardPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using Credit Card.")
    }
}

class PayPalPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using PayPal.")
    }
}

class CashPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) in Cash.")
    }
}

// Context class: Uses a strategy
class ShoppingCart {
    private var paymentStrategy: PaymentStrategy?

    func setPaymentStrategy(strategy: PaymentStrategy) {
        paymentStrategy = strategy
    }

    func checkout(amount: Double) {
        guard let paymentStrategy = paymentStrategy else {
            print("No payment strategy set.")
            return
        }
        paymentStrategy.pay(amount: amount)
    }
}

// Client code
let shoppingCart = ShoppingCart()

let creditCardPayment = CreditCardPayment()
let payPalPayment = PayPalPayment()
let cashPayment = CashPayment()

// Using different payment strategies
shoppingCart.setPaymentStrategy(strategy: creditCardPayment)
shoppingCart.checkout(amount: 100.0)

shoppingCart.setPaymentStrategy(strategy: payPalPayment)
shoppingCart.checkout(amount: 50.0)

shoppingCart.setPaymentStrategy(strategy: cashPayment)
shoppingCart.checkout(amount: 30.0)
