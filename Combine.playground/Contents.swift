import Combine
import Foundation
import UIKit
import XCTest

/*:## Publishers */

//Just Publisher
//"publish" just one value then complete

let justPublisher = Just("Hello Combine")
//You need to _subscribe_ to receive values (here using a sink with a closure)
let justCancellable = justPublisher.sink { value in
    print(value)
}

//Sequence Publisher
//"publish" a series of values immediately
let sequencePublisher = [1, 2, 3, 4, 5].publisher
let sequenceCancellable = sequencePublisher.sink { value in
    print(value)
}

//assign publisher values to a property on an object
class MyClass {
    var property: Int = 0 {
        didSet {
            print("Did set property to \(property)")
        }
    }
}

let object = MyClass()
let subscription3 = sequencePublisher.assign(to: \.property, on: object)

//Timer
let timer = Timer.publish(every: 1.0, on: .main, in: .default)
let timerCancellable = timer.autoconnect().sink { value in
    print("Timer: ", value)
}
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    timerCancellable.cancel()
}

//Notification
let notificationPublisher = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
let notificationCancellable = notificationPublisher.sink { value in
    print("Notification: ", value)
}

//Subjects
//PassthroughSubject
let passthroughSubject = PassthroughSubject<String, Never>()
let passthroughSubjectCancellable = passthroughSubject.sink { value in
    print("passthroughSubject: \(value)")
}
passthroughSubject.send("Hello, World!")
passthroughSubject.send("Another message")

//Subscribing a subject to a publisher
let publisher = ["Here","we","go!"].publisher
publisher.subscribe(passthroughSubject)

//CurrentValueSubject
//Using a CurrentValueSubject to hold and relay the latest value to new subscribers
let currentValueSubject = CurrentValueSubject<String, Never>("Hello, World!")
let currentValueSubjectCancellable = currentValueSubject.sink { value in
    print("currentValueSubject: \(value)")
}
currentValueSubject.send("Updated value")
print(currentValueSubject.value)

//Custom subject
class EvenSubject<Failure: Error>: Subject {
    typealias Output = Int
    private let wrapped: PassthroughSubject<Int, Failure>

    init(value: Int) {
        self.wrapped = PassthroughSubject()
        let evenValue = value % 2 == 0 ? value : -1
        send(evenValue)
    }

    func send(_ value: Int) {
        if value % 2 == 0 {
            wrapped.send(value)
        }
    }

    func send(completion: Subscribers.Completion<Failure>) {
        wrapped.send(completion: completion)
    }

    func send(subscription: any Subscription) {
        wrapped.send(subscription: subscription)
    }

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Int == S.Input {
        wrapped.receive(subscriber: subscriber)
    }
}

let customSubject = EvenSubject<Never>(value: 5)
let customSubjectCancellable = customSubject.sink { value in
    print("customSubject: \(value)")
}
customSubject.send(10)
customSubject.send(11)

//Future and Promises

//a Future delivers exactly one value (or an error) and completes
//It's a lightweight version of publishers, useful in contexts where you'd use a closure callback
//Allows you to call custom methods and return a Result.success or Result.failure
struct User {
    let id: Int
    let name: String
}
let users = [User(id: 0, name: "ABC"), User(id: 1, name: "DEF"), User(id: 2, name: "GHI")]

enum FetchError: Error {
    case userNotFound
}

func fetchUser(for userId: Int, completion: (_ result: Result<User, FetchError>) -> Void) {
    if let user = users.first(where: { $0.id == userId }) {
        completion(Result.success(user))
    } else {
        completion(Result.failure(FetchError.userNotFound))
    }
}

let fetchUserPublisher = PassthroughSubject<Int, FetchError>()

fetchUserPublisher
    .flatMap { userId -> Future<User, FetchError> in
        Future { promise in
            fetchUser(for: userId) { (result) in
                switch result {
                case .success(let user):
                    promise(.success(user))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
}
.map { user in user.name }
.catch { (error) -> Just<String> in
    print("Error occurred: \(error)")
    return Just("Not found")
}
.sink { result in
    print("User is \(result)")
}

fetchUserPublisher.send(0)
fetchUserPublisher.send(5)

/*:## Operators */

//Transforming Operators
//map
let numberPublisher = [1, 2, 3, 4, 5].publisher
let squaredPublisher = numberPublisher.map { $0 * $0 }
let squaredCancellable = squaredPublisher.sink { value in
    print("Squared Number: ", value)
}

//Flatmap
let namesPublisher = ["Alice", "Bob", "Charlie"].publisher
let flatmapPublisher = namesPublisher.flatMap { value in
    value.publisher
}
let flatmapPublisherCancellable = flatmapPublisher.sink { value in
    print("flatmap: ", value)
}

//merge
let publisher1 = [1, 2, 3].publisher
let publisher2 = [4, 5, 6].publisher
let mergePublisher = Publishers.Merge(publisher1, publisher2)
let mergeCancellable = mergePublisher.sink { value in
    print("Merge: ", value)
}

//Filtering operators
//filter
let numbersPublisher = (1...10).publisher
let filterPublisher = numbersPublisher.filter { $0 % 2 == 0 }
let filterCancellable = filterPublisher.sink { value in
    print("Filter: ", value)
}

//compactMap
let stringsPublisher = ["1", "2", "c", "5", "e"].publisher
let compactMapPublisher = stringsPublisher.compactMap(Int.init)
let compactMapCancellable = compactMapPublisher.sink { value in
    print("compactMap: ", value)
}

//debounce
/*
let textPublisher = PassthroughSubject<String, Never>()
let debouncePublisher = textPublisher.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
let debounceCancellable = debouncePublisher.sink { value in
    print("Debounce: ", value)
}

textPublisher.send("A")
textPublisher.send("AB")
textPublisher.send("ABC")
*/

//Combining operators
//combineLatest
let combiningLatestPublisher1 = CurrentValueSubject<Int, Never>(1)
let combiningLatestPublisher2 = CurrentValueSubject<String, Never>("Hello")
let combinePublisher = combiningLatestPublisher1.combineLatest(combiningLatestPublisher2)
let combineCancellable = combinePublisher.sink { first, second in
    print("CombineLatest: (\(first), \(second))")
}

combiningLatestPublisher1.send(2)
combiningLatestPublisher2.send("World")

//zip
let zipPublisher1 = [1, 2, 3].publisher
let zipPublisher2 = ["a", "b", "c"].publisher
let zipPublisher3 = [true, false, false].publisher

//let zipPublisher = zipPublisher1.zip(zipPublisher2)
//let zipCancellable = zipPublisher.sink { first, second in
//    print("Zip: (\(first), \(second))")
//}
let zipPublisher = Publishers.Zip3(zipPublisher1, zipPublisher2, zipPublisher3)
let zipCancellable = zipPublisher.sink { first, second, third in
    print("Zip: (\(first), \(second), \(third))")
}

//switchToLatest
let outerPublisher = PassthroughSubject<AnyPublisher<Int, Never>, Never>()
let innerPublisher1 = CurrentValueSubject<Int, Never>(1)
let innerPublisher2 = CurrentValueSubject<Int, Never>(2)

let switchToLatestPublisher = outerPublisher
    .switchToLatest().sink { value in
        print("switchToLatest: \(value)")
    }

outerPublisher.send(innerPublisher1.eraseToAnyPublisher())
innerPublisher1.send(10)

outerPublisher.send(innerPublisher2.eraseToAnyPublisher())
innerPublisher2.send(20)

innerPublisher1.send(100)

//Error handling operators
//catch
enum SampleError: Error {
    case operationFailed
}

let catchPublisher = (1...5).publisher
catchPublisher.tryMap { value in
    if value == 3 {
        throw SampleError.operationFailed
    }
    return value
}.catch { error in
    print(error)
    return Just(0)
}

let catchCancellable = catchPublisher.sink { value in
    print("Received: \(value)")
}

//mapError
let mapErrorPublisher = (1...5).publisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        return value
    }
    .mapError { _ in
        SampleError.operationFailed
    }

let mapErrorCancellable = mapErrorPublisher.sink { error in
    print("Map Error Received: \(error)")
} receiveValue: { value in
    print("Map Error Received Value: \(value)")
}

//replaceError
/*
let replaceErrorPublisher = (1...5).publisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        return value
    }
    .replaceError(with: -1)

let replaceErrorCancellable = replaceErrorPublisher.sink { value in
    print("Received: \(value)")
} */

let replaceErrorPublisher = (1...5).publisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        return Just(value).eraseToAnyPublisher()
    }
    .replaceError(with: Just(-1).eraseToAnyPublisher())

let replaceErrorCancellable = replaceErrorPublisher.sink { value in
    print(value)
}

//retry
let retryPassthroughSubject = PassthroughSubject<Int, Never>()
let retryPublisher = retryPassthroughSubject
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFailed
        }
        return value
    }
    .retry(2)

let retryCancellable = retryPublisher.sink { completion in
    switch completion {
        case .finished:
            print("Finished")
        case .failure:
            print("Failed")
    }
} receiveValue: { value in
    print("Retry Value: \(value)")
}

retryPassthroughSubject.send(1)
retryPassthroughSubject.send(2)
retryPassthroughSubject.send(3) // 1st failed
retryPassthroughSubject.send(4)
retryPassthroughSubject.send(3) // 2nd failed
retryPassthroughSubject.send(8)
retryPassthroughSubject.send(3) // 3rd failed
retryPassthroughSubject.send(9)

//Making network request
enum NetworkError: Error {
    case badURL
    case badServerResponse
}

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

func fetchPost() -> AnyPublisher<[Post], Error> {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    return URLSession.shared.dataTaskPublisher(for: url)
        .subscribe(on: DispatchQueue.global())
        .tryMap { data, response in
            print("retries")
            guard let httpResponse = response as? HTTPURLResponse,
                    (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.badServerResponse
            }
            return data
        }
        .decode(type: [Post].self, decoder: JSONDecoder())
        .retry(3)
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
}

var cancellables: Set<AnyCancellable> = []

fetchPost().sink { completion in
    switch completion {
        case .finished:
            print("Update UI with posts")
        case .failure(let error):
            print("Error fetching posts: \(error)")
    }
} receiveValue: { posts in
    print(posts)
}
.store(in: &cancellables)

struct MovieResponse: Codable {
    let search: [Movie]
}

struct Movie: Codable {
    let title: String
}

func fetchMovie() -> AnyPublisher<[Movie], Error> {
    guard let url = URL(string: "https://swapi.dev/api/films/1") else {
        return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
    }
    return URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: MovieResponse.self, decoder: JSONDecoder())
        .map(\.search)
        .print("Debug") //To debug, another operator is breakpointOnError or breakpoint or handleEvent
        .breakpointOnError()
        .breakpoint(receiveOutput: { movies in
            return movies.isEmpty
        })
    // The handleEvents operator lets you intercept
    // All stages of a subscription lifecycle
        .handleEvents(receiveSubscription: { _ in
            print("receiveSubscription")
        }, receiveOutput: { value in
            print("receiveOutput: \(value)")
        }, receiveCompletion: { completion in
            print("receiveCompletion: \(completion)")
        }, receiveCancel: {
            print("receiveCancel")
        }, receiveRequest: { _ in
            print("receiveRequest")
        })
        .receive(on: DispatchQueue.main)
        .catch { error in
            Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
}

//Custom operator
extension Publisher where Output == Int {
    func filterEvenNumbers() -> AnyPublisher<Int, Failure> {
        return self.filter { $0 % 2 == 0 }.eraseToAnyPublisher()
    }

    func filterGreaterThanNumbers(value: Int) -> AnyPublisher<Int, Failure> {
        return self.filter { $0 > value }.eraseToAnyPublisher()
    }

    func mapAndFilter<T>(transform: @escaping (Output) -> T, _ includeEven: @escaping (T) -> Bool) -> AnyPublisher<T, Failure> {
        return self.map { transform ($0) }
            .filter {includeEven ($0) }
            .eraseToAnyPublisher()
    }
}

let numbers: [Int] = [1, 2, 3, 4, 5, 6]

let evenNumbersPublisher = numbers.publisher.filterEvenNumbers()

evenNumbersPublisher.sink { number in
    print("Even number: \(number)")
}
.store(in: &cancellables)

let greaterThanTwoPublisher = numbers.publisher.filterGreaterThanNumbers(value: 2)

greaterThanTwoPublisher.sink { number in
    print("Number greater than 2: \(number)")
}
.store(in: &cancellables)


let mapAndFilterPublisher: () = numbers.publisher.mapAndFilter(transform: { $0 * 3 }) { value in
    return value % 2 == 0
}.sink { value in
    print("Map and filter result: \(value)")
}.store(in: &cancellables)

//Unit Test
class CombineUnitTest: XCTestCase {
    func testFirstTest() {
        let expectation = expectation(description: "Receive Value")

        let publisher = Just(1)
            .delay(for: .seconds(1), scheduler: RunLoop.main)

        let _ = publisher.sink(receiveValue: { value in
            XCTAssertEqual(value, 1)
            expectation.fulfill()
        })
    }
}

CombineUnitTest.defaultTestSuite.run()
