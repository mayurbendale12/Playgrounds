struct MobileDevice: CustomStringConvertible {
    let brand: String
    let model: String
    let capacity: Int

    func copy() -> MobileDevice {
        return MobileDevice(brand: brand, model: model, capacity: capacity)
    }

    func clone(capacity: Int) -> MobileDevice {
        return MobileDevice(brand: brand, model: model, capacity: capacity)
    }

    var description: String {
        return "\(brand) \(model): \(capacity)"
    }
}

let iPhone14_128GB = MobileDevice(brand: "Apple", model: "iPhone 14", capacity: 128)
let iPhone14_256GB = iPhone14_128GB.clone(capacity: 258)

print(iPhone14_128GB) 
print(iPhone14_256GB)
