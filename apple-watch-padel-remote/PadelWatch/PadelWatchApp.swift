import SwiftUI

enum Brand {
    static let orange = Color(red: 0xDC/255, green: 0x5F/255, blue: 0x2C/255)
    static let cream  = Color(red: 0xFE/255, green: 0xFB/255, blue: 0xE6/255)
    static let navy   = Color(red: 0x0E/255, green: 0x2A/255, blue: 0x47/255)
    static let navy2  = Color(red: 0x16/255, green: 0x3A/255, blue: 0x5E/255)
}

@main
struct PadelWatchApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack { PinEntryView() }
        }
    }
}
