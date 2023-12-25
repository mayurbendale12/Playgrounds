import Foundation

class Rectangle {
    let width: Int
    let height: Int

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    public func getArea() -> Int {
        return width * height
    }
}

class Square: Rectangle {
    init(size: Int) {
        super.init(width: size, height: size)
    }
}

func getTestArea(shape: Rectangle) {
    print(shape.getArea())
}

let rect = Rectangle(width: 10, height: 20)
getTestArea(shape: rect)

let square = Square(size: 15)
getTestArea(shape: square) // We can substiture base type for a subtype

