import Foundation

class Book {
    let name: String
    let price: Double

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}

class Invoice {
    let book: Book
    let quantity: Int
    var total: Double = 0.0

    init(book: Book, quantity: Int) {
        self.book = book
        self.quantity = quantity
        self.total = self.calculateTotal()
    }

    // This class is doing multiple things like calculateTotal, printInvoice and saveToFile which violates Single Responsibility Pronciple. To solve this, we can create new classes for printing and persistence
    func calculateTotal() -> Double {
        let price = book.price * Double(quantity)
        return price
    }

    func printInvoice() {
        print("\(quantity) x \(book.name)         \(book.price)$")
        print("Total: \(total)")
    }

    func saveToFile(filename: String) {
        // Creates a file with given name and writes the invoice
    }

}

class InvoicePrinter {
    private let invoice: Invoice
    private let book: Book

    init(invoice: Invoice, book: Book) {
        self.invoice = invoice
        self.book = book
    }

    func printInvoice() {
        print("\(invoice.quantity) x \(book.name)         \(book.price)$")
        print("Total: \(invoice.total)")
    }
}

class InvoicePersistence {
    private let invoice: Invoice

    init(invoice: Invoice) {
        self.invoice = invoice
    }

    func saveToFile(filename: String) {
        // Creates a file with given name and writes the invoice
    }
}
