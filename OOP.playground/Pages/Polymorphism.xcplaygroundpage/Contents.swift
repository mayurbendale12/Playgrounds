/*: ## Example 1 */
class Shape {
    func draw() {
        print("Drawing a shape")
    }
}

class Circle: Shape {
    override func draw() {
        print("Drawing a circle")
    }
}

class Square: Shape {
    override func draw() {
        print("Drawing a square")
    }
}

func drawShape(shape: Shape) {
    shape.draw()
}

drawShape(shape: Circle()) // prints "Drawing a circle"
drawShape(shape: Square()) // prints "Drawing a square"

/*: ## Example 2*/
protocol Drawable {
    func draw()
}

struct TriangleShape: Drawable {
    func draw() { print("Drawing triangle") }
}

final class SquareShape: Drawable {
    func draw() { print("Drawing square") }
}

func render(_ items: [Drawable]) { items.forEach { $0.draw() } }

render([TriangleShape(), SquareShape()]) // Drawing triangle / Drawing square
