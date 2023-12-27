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
