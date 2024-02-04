// Command protocol: Defines the interface for executing a command
protocol Command {
    func execute()
}

// Receiver class: Knows how to perform the operation associated with a command
class Light {
    func turnOn() {
        print("Light is ON")
    }

    func turnOff() {
        print("Light is OFF")
    }
}

// ConcreteCommand classes: Implement the Command interface and encapsulate a specific operation
class TurnOnLightCommand: Command {
    private let light: Light

    init(light: Light) {
        self.light = light
    }

    func execute() {
        light.turnOn()
    }
}

class TurnOffLightCommand: Command {
    private let light: Light

    init(light: Light) {
        self.light = light
    }

    func execute() {
        light.turnOff()
    }
}

// Invoker class: Asks the command to execute the request
class RemoteControl {
    private var command: Command?

    func setCommand(command: Command) {
        self.command = command
    }

    func pressButton() {
        command?.execute()
    }
}

// Client code
let light = Light()

let turnOnCommand = TurnOnLightCommand(light: light)
let turnOffCommand = TurnOffLightCommand(light: light)

let remote = RemoteControl()

// Configuring the remote with commands
remote.setCommand(command: turnOnCommand)

// Pressing the button to execute the command
remote.pressButton()

// Configuring the remote with another command
remote.setCommand(command: turnOffCommand)

// Pressing the button to execute the second command
remote.pressButton()
