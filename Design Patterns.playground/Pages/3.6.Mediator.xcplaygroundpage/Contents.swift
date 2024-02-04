protocol ChatUser {
    var name: String { get }
    func send(message: String, to: ChatUser)
    func receive(message: String, from: ChatUser)
    func broadcast(message: String)
}

class User: ChatUser {
    var name: String
    private var chatMediator: ChatMediator

    init(name: String, chatMediator: ChatMediator) {
        self.name = name
        self.chatMediator = chatMediator
        chatMediator.register(user: self)
    }

    func send(message: String, to: ChatUser) {
        chatMediator.send(message: message, from: self, to: to)
    }

    func receive(message: String, from: ChatUser) {
        print("\(name) received message: '\(message)' from \(from.name)")
    }

    func broadcast(message: String) {
        chatMediator.broadcast(message: message, from: self)
    }
}

class ChatMediator {
    private var users: [ChatUser] = []

    func register(user: ChatUser) {
        users.append(user)
    }

    func send(message: String, from: ChatUser, to: ChatUser) {
        to.receive(message: message, from: from)
    }

    func broadcast(message: String, from: ChatUser) {
        let modifiedUsers = users.filter { $0.name != from.name }
        for user in modifiedUsers {
            user.receive(message: message, from: from)
        }
    }
}

let chatMediator = ChatMediator()
let user1 = User(name: "Alice", chatMediator: chatMediator)
let user2 = User(name: "Bob", chatMediator: chatMediator)
let user3 = User(name: "Charlie", chatMediator: chatMediator)

user1.send(message: "Hello, Bob. How are you?", to: user2)

user2.send(message: "I'm good, thanks. How about you?", to: user1)

user3.broadcast(message: "Hello, everyone. I just joined the chat.")
