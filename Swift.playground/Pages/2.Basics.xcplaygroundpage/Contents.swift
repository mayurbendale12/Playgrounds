//: [Previous](@previous)
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

var environment = "development"
let maximumNumberOfLoginAttemptsConstant: Int
// maximumNumberOfLoginAttempts has no value yet.
if environment == "development" {
    maximumNumberOfLoginAttemptsConstant = 100
} else {
    maximumNumberOfLoginAttemptsConstant = 10
}
// Now maximumNumberOfLoginAttempts has a value, and can be read.

var x = 0.0, y = 0.0, z = ""
var red, green, blue: Double

let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

print("Value of π: \(π)")

let sampleValuesToPrint = [maximumNumberOfLoginAttempts, currentLoginAttempt]
for value in 0..<sampleValuesToPrint.count {
    print(value, separator: " # ", terminator: " ")
}

// This is a comment.

/* This is also a comment
but is written over multiple lines. */

/* This is the start of the first multiline comment.
    /* This is the second, nested multiline comment. */
This is the end of the first multiline comment. */

let cat = "🐱"; print(cat)

let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

/*: ## Type Aliases */

typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

/*: ## Tuples */
let http404Error = (404, "Not Found")
// http404Error is of type (Int, String), and equals (404, "Not Found")

let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"
print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"

let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// Prints "The status code is 404"

print("The status code is \(http404Error.0)")
// Prints "The status code is 404"
print("The status message is \(http404Error.1)")
// Prints "The status message is Not Found"

let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
// Prints "The status code is 200"
print("The status message is \(http200Status.description)")
// Prints "The status message is OK"

/*: ## Optionals */
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// The type of convertedNumber is "optional Int"

var serverResponseCode: Int? = 404
// serverResponseCode contains an actual Int value of 404
serverResponseCode = nil
// serverResponseCode now contains no value
var surveyAnswer: String?
// surveyAnswer is automatically set to nil

if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
// Prints "convertedNumber contains some integer value."


if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}
// Prints "The string "123" has an integer value of 123"

let myNumber = Int(possibleNumber)
// Here, myNumber is an optional integer
if let myNumber = myNumber {
    // Here, myNumber is a non-optional integer
    print("My number is \(myNumber)")
}
// Prints "My number is 123"
if let myNumber {
    print("My number is \(myNumber)")
}
// Prints "My number is 123"
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"

//Nil-coalescing
let name: String? = nil
let greeting = "Hello, " + (name ?? "friend") + "!"
print(greeting)
// Prints "Hello, friend!"

//Force unwrapping
let number = convertedNumber!

//Implicitly unwrapped optionals
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // Unwrapped automatically
let optionalString = assumedString
// The type of optionalString is "String?" and assumedString isn't force-unwrapped.
if assumedString != nil {
    print(assumedString!)
}
// Prints "An implicitly unwrapped optional string."
if let definiteString = assumedString {
    print(definiteString)
}
// Prints "An implicitly unwrapped optional string."

/*: ## Error Handling */
enum SandwichError: Error {
    case outOfCleanDishes
    case missingIngredients([String])
}

func makeASandwich() throws {
}

do {
    try makeASandwich()
    //eatASandwich
} catch SandwichError.outOfCleanDishes {
    //washDishes
} catch SandwichError.missingIngredients(let ingredients) {
    //buyGroceries
}

/*: ## Assertions and Preconditions */
let age = 12
assert(age >= 0, "A person's age can't be less than zero.")
// This assertion fails because -3 isn't >= 0.

//You can omit the assertion message
assert(age >= 0)

if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age >= 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.")
}

// In the implementation of a subscript...
let index = 1
precondition(index > 0, "Index must be greater than zero.")
//: [Next](@next)
