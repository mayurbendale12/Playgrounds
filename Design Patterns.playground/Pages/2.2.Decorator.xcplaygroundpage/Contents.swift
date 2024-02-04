protocol Transporting {
    func getSpeed() -> Double
    func getTraction() -> Double
}

// Core Component
final class RaceCar: Transporting {
    private let speed = 10.0
    private let traction = 10.0

    func getSpeed() -> Double {
        return speed
    }

    func getTraction() -> Double {
        return traction
    }
}

let raceCar = RaceCar()
let defaultSpeed = raceCar.getSpeed()
let defaultTraction = raceCar.getTraction()

class OffRoadTireDecorator: Transporting {
    private let transportable: Transporting

    init(transportable: Transporting) {
        self.transportable = transportable
    }

    func getSpeed() -> Double {
        return transportable.getSpeed() - 3.0
    }

    func getTraction() -> Double {
        return transportable.getTraction() + 3.0
    }
}

// Create Race Car
let defaultRaceCar = RaceCar()
defaultRaceCar.getSpeed()
defaultRaceCar.getTraction()

// Modify Race Car
let offRoadRaceCar = OffRoadTireDecorator(transportable: defaultRaceCar)
offRoadRaceCar.getSpeed()
offRoadRaceCar.getTraction()
