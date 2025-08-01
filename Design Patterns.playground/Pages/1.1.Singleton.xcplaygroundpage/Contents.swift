class Settings {
    static let shared = Settings()
    var username: String?

    private init() { }
}

Settings.shared.username = "ABC"
