import Foundation

//: ## Example 1
typealias Memento = [String: String]

protocol MementoConvertible {
    var memento: Memento { get }
    init?(memento: Memento)
}

struct GameState: MementoConvertible {
    private enum Keys {
        static let chapter = "com.valve.halflife.chapter"
        static let weapon = "com.valve.halflife.weapon"
    }

    var chapter: String
    var weapon: String

    init(chapter: String, weapon: String) {
        self.chapter = chapter
        self.weapon = weapon
    }

    init?(memento: Memento) {
        guard let mementoChapter = memento[Keys.chapter],
              let mementoWeapon = memento[Keys.weapon] else {
            return nil
        }

        chapter = mementoChapter
        weapon = mementoWeapon
    }

    var memento: Memento {
        return [Keys.chapter: chapter, Keys.weapon: weapon]
    }
}

enum CheckPoint {
    private static let defaults = UserDefaults.standard

    static func save(_ state: MementoConvertible, saveName: String) {
        defaults.set(state.memento, forKey: saveName)
        defaults.synchronize()
    }

    static func restore(saveName: String) -> Any? {
        return defaults.object(forKey: saveName)
    }
}

var gameState = GameState(chapter: "Black Mesa Inbound", weapon: "Crowbar")

gameState.chapter = "Anomalous Materials"
gameState.weapon = "Glock 17"
CheckPoint.save(gameState, saveName: "gameState1")

gameState.chapter = "Unforeseen Consequences"
gameState.weapon = "MP5"
CheckPoint.save(gameState, saveName: "gameState2")

gameState.chapter = "Office Complex"
gameState.weapon = "Crossbow"
CheckPoint.save(gameState, saveName: "gameState3")

if let memento = CheckPoint.restore(saveName: "gameState1") as? Memento {
    let finalState = GameState(memento: memento)
    dump(finalState)
}
//: ## Example 2
// Memento: Represents the snapshot of the editor's state
class EditorMemento {
    private let text: String

    init(text: String) {
        self.text = text
    }

    func getText() -> String {
        return text
    }
}

// Originator: Represents the text editor
class TextEditor {
    private var currentText: String

    init(initialText: String) {
        self.currentText = initialText
    }

    func createMemento() -> EditorMemento {
        return EditorMemento(text: currentText)
    }

    func restoreFromMemento(_ memento: EditorMemento) {
        currentText = memento.getText()
    }

    func type(text: String) {
        currentText += text
    }

    func getText() -> String {
        return currentText
    }
}

// Caretaker: Manages the list of editor mementos
class EditorHistory {
    private var mementos = [EditorMemento]()

    func saveMemento(_ memento: EditorMemento) {
        mementos.append(memento)
    }

    func undo() -> EditorMemento? {
        guard let lastMemento = mementos.popLast() else {
            return nil
        }
        return lastMemento
    }
}

// Client code
let textEditor = TextEditor(initialText: "Hello, ")

let editorHistory = EditorHistory()

// Typing and saving mementos
textEditor.type(text: "world!")
editorHistory.saveMemento(textEditor.createMemento())

textEditor.type(text: " This is a Memento example.")
editorHistory.saveMemento(textEditor.createMemento())

print("Current Text: \(textEditor.getText())")

// Undo the last change
if let undoMemento = editorHistory.undo() {
    textEditor.restoreFromMemento(undoMemento)
    print("After Undo: \(textEditor.getText())")
}
