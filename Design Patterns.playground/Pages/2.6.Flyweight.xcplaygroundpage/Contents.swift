import Foundation

// Flyweight interface
protocol Shape {
    func draw(position: CGPoint)
}

// Concrete Flyweight
class Circle: Shape {
    private var radius: CGFloat

    init(radius: CGFloat) {
        self.radius = radius
    }

    func draw(position: CGPoint) {
        print("Drawing a circle with radius \(radius) at position \(position)")
    }
}

// Flyweight Factory
class ShapeFactory {
    private var circleCache: [CGFloat: Shape] = [:]

    func getCircle(radius: CGFloat) -> Shape {
        if let cachedCircle = circleCache[radius] {
            return cachedCircle
        } else {
            let newCircle = Circle(radius: radius)
            circleCache[radius] = newCircle
            return newCircle
        }
    }
}

// Client
class DrawingClient {
    private let shapeFactory = ShapeFactory()

    func drawCircle(radius: CGFloat, position: CGPoint) {
        let circle = shapeFactory.getCircle(radius: radius)
        circle.draw(position: position)
    }
}

// Usage
let drawingClient = DrawingClient()

drawingClient.drawCircle(radius: 5.0, position: CGPoint(x: 10, y: 20))
drawingClient.drawCircle(radius: 5.0, position: CGPoint(x: 30, y: 40))
