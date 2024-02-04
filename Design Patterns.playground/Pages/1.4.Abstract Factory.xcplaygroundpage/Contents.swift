protocol Car {
    func drive()
}

class Sedan: Car {
    func drive() {
        print("drive a Sedan")
    }
}

class SUV: Car {
    func drive() {
        print("drive a SUV")
    }
}

/// abstract factory
protocol Factory {
    func produce() -> Car
}

/// concrete factory
class SedanFactory: Factory {
    func produce() -> Car {
        return Sedan()
    }
}

/// concrete factory
class SUVFactory: Factory {
    func produce() -> Car {
        return SUV()
    }
}

let sedanFactory = SedanFactory()
let sedan = sedanFactory.produce()
sedan.drive()
let suvFactory = SUVFactory()
let suv = suvFactory.produce()
suv.drive()

// If you want to add Truck then you can easily add it
class Truck: Car {
    func drive() {
        print("drive a truck")
    }
}

class TruckFactory: Factory {
    func produce() -> Car {
        return Truck()
    }
}

let truckFactory = TruckFactory()
let truck = truckFactory.produce()
truck.drive()
