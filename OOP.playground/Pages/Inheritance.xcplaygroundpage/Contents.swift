class Shape {
    func calCulateArea() {
        fatalError("This method should be overridden by subclasses.")
    }
}

class Circle: Shape {
    var radius: Double

    init(radius: Double) {
        self.radius = radius
    }

    // Method overriding
    override func calCulateArea() {
        let area = Double.pi * radius * radius
        print("Area of Cirle is \(area)")
    }
}

class Square: Shape {
    var sideLength: Double

    init(sideLength: Double) {
        self.sideLength = sideLength
    }

    override func calCulateArea() {
        let area = sideLength * sideLength
        print("Area of Square is \(area)")
    }
}

let circle = Circle(radius: 4)
let square = Square(sideLength: 5)

circle.calCulateArea()
square.calCulateArea()
