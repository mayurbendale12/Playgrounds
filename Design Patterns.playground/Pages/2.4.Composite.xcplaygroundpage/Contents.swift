// Component
protocol Shape {
    func draw()
}

// Leaf
class Circle: Shape {
    func draw() {
        print("Drawing Circle")
    }
}

class Square: Shape {
    func draw() {
        print("Drawing Square")
    }
}

// Composite
class CompositeShape: Shape {
    private var shapes: [Shape] = []

    init(shapes: [Shape]) {
        self.shapes = shapes
    }

    func draw() {
        print("Drawing CompositeShape")
        for shape in shapes {
            shape.draw()
        }
    }
}

// Client code
let circle = Circle()
let square = Square()

let composite = CompositeShape(shapes: [circle, square])
composite.draw()
