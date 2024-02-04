// Protocol representing the real object
protocol RealSubject {
    func request()
}

// Concrete implementation of the real object
class RealObject: RealSubject {
    func request() {
        print("RealObject handling request")
    }
}

// Proxy class implementing the same protocol as the real object
class Proxy: RealSubject {
    private var realObject: RealObject?

    func request() {
        // Lazy initialization of the real object
        if realObject == nil {
            realObject = RealObject()
        }

        // Additional logic before or after forwarding the request to the real object
        print("Proxy handling request")

        // Forward the request to the real object
        realObject?.request()

        // Additional logic after the request has been handled by the real object
        print("Proxy done handling request")
    }
}

// Client code
let proxy = Proxy()
proxy.request()
