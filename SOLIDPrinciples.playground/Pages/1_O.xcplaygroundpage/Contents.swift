//Continueing with the Single responsibility priciple, in InvoicePersistence we are saving to file, new requirement comes and now wanted to save oin database. In this case we will add one more function to save in database in same class but this violets this principle. Instead we can prevent this like below:

protocol InvoicePersistence {
    func save(filename: String)
}

class Invoice { }

class FilePersistence: InvoicePersistence {
    let invoice: Invoice

    public init(invoice: Invoice) {
        self.invoice = invoice
    }

    public func save(filename: String) {
        // Creates a file with given name and writes the invoice
    }
}

class DatabasePersistence: InvoicePersistence {
    let invoice: Invoice

    init(invoice: Invoice) {
        self.invoice = invoice
    }

    func save(filename: String) {
        // save invoice in Database
    }
}
