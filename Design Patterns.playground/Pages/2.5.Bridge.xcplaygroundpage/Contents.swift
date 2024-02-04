// Abstraction
protocol Shape {
    var color: Color { get set }
    func draw()
}

// Implementation
protocol Color {
    func applyColor() -> String
}

// Concrete Implementations
class RedColor: Color {
    func applyColor() -> String {
        return "Applying red color"
    }
}

class BlueColor: Color {
    func applyColor() -> String {
        return "Applying blue color"
    }
}

// Refined Abstraction
class Square: Shape {
    var color: Color

    init(color: Color) {
        self.color = color
    }

    func draw() {
        print("Drawing Square. \(color.applyColor())")
    }
}

class Circle: Shape {
    var color: Color

    init(color: Color) {
        self.color = color
    }

    func draw() {
        print("Drawing Circle. \(color.applyColor())")
    }
}

// Client code
let redColor = RedColor()
let blueColor = BlueColor()

let redSquare = Square(color: redColor)
let blueCircle = Circle(color: blueColor)

redSquare.draw()
blueCircle.draw()
