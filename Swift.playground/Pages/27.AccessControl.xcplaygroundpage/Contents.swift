//: [Previous](@previous)
open class SomeOpenClass {}
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

class MySubClass: SomeOpenClass {
    open var someOpenVariable = 0
}
public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

public class AnotherPublicClass {                // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

class AnotherInternalClass {                     // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

fileprivate class AnotherFilePrivateClass {      // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

private class AnotherPrivateClass {              // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}

//Below will give error: Function must be declared private or fileprivate because its result uses a private type/
//func someFunction() -> (SomeInternalClass, SomePrivateClass) {
//}

public enum CompassPoint {
    case north
    case south
    case east
    case west
}

public struct TrackedString {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")

protocol SomeProtocol {
    func doSomething()
}
struct SomeStruct {
    private var privateVariable = 12
}
extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}

//: [Next](@next)
