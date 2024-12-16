//: [Previous](@previous)
/*: ## Assignment operator */
let b = 10
var a = 5
a = b
// a is now equal to 10

let (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2
/*: ## Unary Minus/Plus operator */
let three = 3
let minusThree = -three       // minusThree equals -3
let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"

let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix equals -6
/*: ## Compound Assignment operator */
var a = 1
a += 2
// a is now equal to 3
/*: ## Nil-Coalescing operator */
let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil
var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"
/*: ## Close Range operator */
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
/*: ## Half Open Range operator */
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}
/*: ## One-Sided Range operator */
for name in names[2...] {
    print(name)
}

for name in names[...2] {
    print(name)
}

for name in names[..<2] {
    print(name)
}
let range = ...5
range.contains(7)   // false
range.contains(4)   // true
range.contains(-1)  // true
/*: ## Logical Operator */
//Logical NOT (!a)
//Logical AND (a && b)
//Logical OR (a || b)

let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}

let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
//: [Next](@next)
