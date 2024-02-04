// Element protocol: Defines the interface for elements that can be visited
protocol DocumentElement {
    func accept(visitor: DocumentVisitor)
}

// ConcreteElement classes: Implement the Element interface
class TextElement: DocumentElement {
    let text: String

    init(text: String) {
        self.text = text
    }

    func accept(visitor: DocumentVisitor) {
        visitor.visit(element: self)
    }
}

class ImageElement: DocumentElement {
    let imageName: String

    init(imageName: String) {
        self.imageName = imageName
    }

    func accept(visitor: DocumentVisitor) {
        visitor.visit(element: self)
    }
}

// Visitor protocol: Declares a visit method for each ConcreteElement type
protocol DocumentVisitor {
    func visit(element: TextElement)
    func visit(element: ImageElement)
}

// ConcreteVisitor class: Implements the Visitor interface
class HTMLExportVisitor: DocumentVisitor {
    func visit(element: TextElement) {
        print("<p>\(element.text)</p>")
    }

    func visit(element: ImageElement) {
        print("<img src=\"\(element.imageName)\" alt=\"Image\">")
    }
}

// Client code
let textElement = TextElement(text: "This is a paragraph.")
let imageElement = ImageElement(imageName: "example.jpg")

let htmlVisitor = HTMLExportVisitor()

textElement.accept(visitor: htmlVisitor)
imageElement.accept(visitor: htmlVisitor)
