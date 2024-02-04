// Context: Contains information that is global to the interpreter
class Context {
    var variables: [String: Int] = [:]

    func setValue(variable: String, value: Int) {
        variables[variable] = value
    }

    func getValue(variable: String) -> Int? {
        return variables[variable]
    }
}

// Expression: The protocol that declares the interpret method
protocol Expression {
    func interpret(context: Context) -> Int
}

// TerminalExpression: Represents a terminal expression in the grammar (e.g., a variable or a constant)
class VariableExpression: Expression {
    private var variable: String

    init(variable: String) {
        self.variable = variable
    }

    func interpret(context: Context) -> Int {
        guard let value = context.getValue(variable: variable) else {
            fatalError("Variable not found: \(variable)")
        }
        return value
    }
}

// NonterminalExpression: Represents a non-terminal expression in the grammar (e.g., addition)
class AdditionExpression: Expression {
    private var left: Expression
    private var right: Expression

    init(left: Expression, right: Expression) {
        self.left = left
        self.right = right
    }

    func interpret(context: Context) -> Int {
        return left.interpret(context: context) + right.interpret(context: context)
    }
}

// Client: Uses the interpreter to evaluate expressions
class Client {
    func evaluate(expression: Expression, context: Context) -> Int {
        return expression.interpret(context: context)
    }
}

// Usage
let context = Context()
context.setValue(variable: "x", value: 10)
context.setValue(variable: "y", value: 5)

let variableX = VariableExpression(variable: "x")
let variableY = VariableExpression(variable: "y")
let sumExpression = AdditionExpression(left: variableX, right: variableY)

let client = Client()
let result = client.evaluate(expression: sumExpression, context: context)
print("Result: \(result)")


