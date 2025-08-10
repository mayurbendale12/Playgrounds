/*: ## Example 1 */
// Abstract class
class Car {
    var brand: String

    init(brand: String) {
        self.brand = brand
    }

    func start() {
        fatalError("This method should be overridden by subclasses.")
    }
}

// Concrete subclass
class ElectricCar: Car {
    override func start() {
        print("Electric car started silently.")
    }
}

let myCar: Car = ElectricCar(brand: "Tesla")
// You interact with the car through a simple interface without knowing the specific details of how it starts.
myCar.start()

/*: ## Example 2 */
// Abstract contract
protocol PaymentMethod {
    func authorize(amount: Double) -> Bool
    func capture(amount: Double) -> Bool
}

// Concrete implementations hide details behind the protocol
final class CreditCard: PaymentMethod {
    func authorize(amount: Double) -> Bool {
        /* network, risk checks */
        return amount <= 5_000
    }

    func capture(amount: Double) -> Bool {
        /* settlement */
        return true
    }
}

final class ApplePay: PaymentMethod {
    func authorize(amount: Double) -> Bool {
        /* tokenized auth */
        return amount <= 10_000
    }

    func capture(amount: Double) -> Bool {
        return true
    }
}

// Client code depends on the abstraction, not concrete types
func checkout(using method: PaymentMethod, amount: Double) -> Bool {
    guard method.authorize(amount: amount) else { return false }
    return method.capture(amount: amount)
}
