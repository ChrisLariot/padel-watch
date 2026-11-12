import SwiftUI

@main
struct PadelCompanionApp: App {
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 20) {
                Image(systemName: "applewatch")
                    .font(.system(size: 60))
                    .foregroundStyle(Color(red: 0xDC/255, green: 0x5F/255, blue: 0x2C/255))
                Text("Padel Score").font(.title.bold())
                Text("Open the Watch app on this iPhone, scroll to Available Apps and tap Install next to Padel Score.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 24)
            }
            .padding()
        }
    }
}
