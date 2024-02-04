//: ## Example 1
protocol NewDeathStarSuperLaserAiming {
    var angleV: Double { get }
    var angleH: Double { get }
}

//Adaptee
struct OldDeathStarSuperlaserTarget {
    let angleHorizontal: Float
    let angleVertical: Float

    init(angleHorizontal: Float, angleVertical: Float) {
        self.angleHorizontal = angleHorizontal
        self.angleVertical = angleVertical
    }
}

//Adapter
struct NewDeathStarSuperlaserTarget: NewDeathStarSuperLaserAiming {

    private let target: OldDeathStarSuperlaserTarget

    var angleV: Double {
        return Double(target.angleVertical)
    }

    var angleH: Double {
        return Double(target.angleHorizontal)
    }

    init(_ target: OldDeathStarSuperlaserTarget) {
        self.target = target
    }
}

let target = OldDeathStarSuperlaserTarget(angleHorizontal: 14.0, angleVertical: 12.0)
let newFormat = NewDeathStarSuperlaserTarget(target)

newFormat.angleH
newFormat.angleV

//: ## Example 2


// Target protocol representing the common audio player interface
protocol AudioPlayer {
    func play()
    func pause()
    func stop()
}

// Adaptee representing the third-party audio player library
class ThirdPartyAudioPlayer {
    func playSpecificFormat() {
        print("Playing audio in a specific format")
    }

    func stopSpecificFormat() {
        print("Stopping audio in a specific format")
    }
}

// Adapter class conforming to the AudioPlayer interface
class AudioPlayerAdapter: AudioPlayer {
    private let adaptee: ThirdPartyAudioPlayer

    init(adaptee: ThirdPartyAudioPlayer) {
        self.adaptee = adaptee
    }

    func play() {
        adaptee.playSpecificFormat()
    }

    func pause() {
        // Not applicable in the third-party library, so do nothing
    }

    func stop() {
        adaptee.stopSpecificFormat()
    }
}

// Client code using the common AudioPlayer interface
let adaptee = ThirdPartyAudioPlayer()
let audioPlayerAdapter = AudioPlayerAdapter(adaptee: adaptee)

audioPlayerAdapter.play()
audioPlayerAdapter.stop()
