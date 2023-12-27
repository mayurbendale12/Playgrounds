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
