import Foundation

class FileSystemManager {
    func save(string: String) {
        // Open a file
        // Save the string in this file
        // Close the file
   }
}

class Handler {
    let fileManager = FileSystemManager()

    func handle(string: String) {
        fileManager.save(string: string)
    }
}

//FileSystemManager is a low-level module and it’s easy to reuse in other projects. The problem is the high-level module Handler which is not reusable because is tightly coupled with FileSystemManager. We should be able to reuse the high-level module with different kinds of storage like a database, cloud, and so on. We can solve this dependency using protocol Storage. In this way, Handler can use this abstract protocol without caring for the kind of storage used. With this approach, we can change easily from a filesystem to a database.


protocol Storage {
    func save(string: String)
}

class FileSystemManager1: Storage {
    func save(string: String) {
        // Open a file in read-mode
        // Save the string in this file
        // Close the file
    }
}

class DatabaseManager1: Storage {
    func save(string: String) {
        // Connect to the database
        // Execute the query to save the string in a table
        // Close the connection
    }
}

class Handler1 {
    let storage: Storage
    // Storage types
    init(storage: Storage) {
        self.storage = storage
    }

    func handle(string: String) {
        storage.save(string: string)
    }
}
