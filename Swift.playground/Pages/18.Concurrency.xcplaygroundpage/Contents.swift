//: [Previous](@previous)
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
/*: ## Defining and Calling Asynchronous Functions */
func listPhotos(inGallery name: String) async -> [String] {
    let result = ["Photo1", "Photo2", "Photo3"] // ... some asynchronous networking code ...
    return result
}

func downloadPhoto(named name: String) async -> UIImage {
    return UIImage()
}

func show(_ image: UIImage) {
}

func show(_ image: [UIImage]) {
}

let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)

//You can explicitly insert a suspension point by calling the Task.yield() method.
func generateSlideshow(forGallery gallery: String) async {
    let photos = await listPhotos(inGallery: gallery)
    for photo in photos {
        // ... render a few seconds of video for this photo ...
        await Task.yield()
    }
}

//The Task.sleep(for:tolerance:clock:) method is useful when writing simple code to learn how concurrency works. This method suspends the current task for at least the given amount of time.
func getPhotos(inGallery name: String) async throws -> [String] {
    try await Task.sleep(for: .seconds(2))
    return ["IMG001", "IMG99", "IMG0404"]
}
let photos = try await getPhotos(inGallery: "A Rainy Weekend")

func listDownloadedPhotos(inGallery name: String) throws -> [String] {
    let downloadedPhotos = ["IMG001", "IMG99", "IMG0404"]
    return downloadedPhotos
}

//You can use Result to store the error for code elsewhere to handle it. These approaches let you call throwing functions from nonthrowing code.
func availableRainyWeekendPhotos() -> Result<[String], Error> {
    return Result {
        try listDownloadedPhotos(inGallery: "A Rainy Weekend")
    }
}

/*: ## Asynchronous Sequences */

let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}

/*: ## Calling Asynchronous Functions in Parallel */
//Calling an asynchronous function with await runs only one piece of code at a time. While the asynchronous code is running, the caller waits for that code to finish before moving on to run the next line of code
let photo1 = await downloadPhoto(named: photoNames[0])
let photo2 = await downloadPhoto(named: photoNames[1])
let photo3 = await downloadPhoto(named: photoNames[2])

show([photo1, photo2, photo3])

//To call an asynchronous function and let it run in parallel with code around it, write async in front of let when you define a constant, and then write await each time you use the constant.
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])


let allPhotos = await [firstPhoto, secondPhoto, thirdPhoto]
show(allPhotos)

/*: ## Tasks and Task Groups */
await withTaskGroup(of: UIImage.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        group.addTask {
            return await downloadPhoto(named: name)
        }
    }

    for await photo in group {
        show(photo)
    }
}

let downloadedPhotos = await withTaskGroup(of: UIImage.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        group.addTask {
            return await downloadPhoto(named: name)
        }
    }

    var results: [UIImage] = []
    for await photo in group {
        results.append(photo)
    }

    return results
}

//Task Cancellation
let photos1 = await withTaskGroup(of: Optional<UIImage>.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        let added = group.addTaskUnlessCancelled {
            Task.isCancelled ? nil : await downloadPhoto(named: name)
        }
        guard added else { break }
    }

    var results: [UIImage] = []
    for await photo in group {
        if let photo { results.append(photo) }
    }
    return results
}

let task = await withTaskCancellationHandler {
  var sum = 0
  while sum < 5 {
    sum += 1
  }
  return sum
} onCancel: {
  // This onCancel closure might execute concurrently with the operation.
}

/*: ## Unstructured Concurrency */
let unstructuredTask = Task {
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
}

unstructuredTask.cancel()

/*: ## Main Actor */
//To ensure that function runs on main actor
@MainActor
func show(_: Data) {
    // ... UI code to display the photo ...
}

func downloadAndShowPhoto(named name: String) async {
    let photo = await downloadPhoto(named: name)
    show(photo)
}

let downloadedPhoto = await downloadPhoto(named: "Trees at Sunrise")
//To ensure that closure runs on main actor
Task { @MainActor in
    show(downloadedPhoto)
}

//You can also write @MainActor on a structure, class, or enumeration, properties or methods
@MainActor
struct PhotoGallery {
    @MainActor var photoNames: [String]
    var hasCachedPhotos = false

    @MainActor func drawUI() { /* ... UI code ... */ }
    func cachePhotos() { /* ... networking code ... */ }
}
/*: ## Actors */
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }

    //The update(with:) method is already running on the actor, so it doesn’t mark its access to properties like max with await.
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}

let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)

/*: ## Sendable Types */
//This strucure has only sendable properties so its implicitly sendable
struct TemperatureReading: Sendable {
    var measurement: Int
}

extension TemperatureLogger {
    func addReading(from reading: TemperatureReading) {
        measurements.append(reading.measurement)
    }
}

let temperatureLogger = TemperatureLogger(label: "Tea kettle", measurement: 85)
let reading = TemperatureReading(measurement: 45)
await temperatureLogger.addReading(from: reading)

//To explicitly mark a type as not being sendable, write ~Sendable after the type
//This code gives error: Conformance to 'Sendable' cannot be suppressed
//Another approach is to use @unchecked Sendable
/*
struct FileDescriptor: ~Sendable {
    let rawValue: Int
}*/

PlaygroundPage.current.finishExecution()
//: [Next](@next)
