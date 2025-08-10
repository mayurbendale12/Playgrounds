class BankAccount {
    private var balance: Double // Encapsulated data

    init(initialBalance: Double) {
        self.balance = initialBalance
    }

    func deposit(amount: Double) {
        balance += amount
        print("Deposited \(amount). New balance: \(balance)")
    }

    func withdraw(amount: Double) {
        if amount <= balance {
            balance -= amount
            print("Withdrawn \(amount). New balance: \(balance)")
        } else {
            print("Insufficient funds.")
        }
    }
}

let myAccount = BankAccount(initialBalance: 1000.0)
myAccount.deposit(amount: 500.0)
myAccount.withdraw(amount: 200.0)
