import SwiftUI
import WatchKit

/// Top = Team A, bottom = Team B, long-press anywhere = undo.
struct ScoreView: View {
    let pin: String
    @State private var m: MatchView?
    @State private var error: String?
    @State private var busy = false
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        Group {
            if let m {
                VStack(spacing: 0) {
                    half(team: 0, m: m, bg: Brand.orange, fg: .white)
                    ZStack {
                        Brand.navy
                        Text(m.over ? "FINAL" : "G \(m.games[0])-\(m.games[1])")
                            .font(.caption2.bold()).foregroundStyle(.white)
                    }.frame(height: 18)
                    half(team: 1, m: m, bg: Brand.cream, fg: Brand.navy)
                }
                .ignoresSafeArea()
                .onLongPressGesture { act("undo") }
            } else {
                Text(error ?? "Loading…").foregroundStyle(Brand.cream).multilineTextAlignment(.center)
            }
        }
        .background(Brand.navy.ignoresSafeArea())
        .navigationBarBackButtonHidden(m != nil ? false : false)
        .task { await load() }
        .onReceive(timer) { _ in Task { await load() } }
    }

    func half(team: Int, m: MatchView, bg: Color, fg: Color) -> some View {
        Button { act(team == 0 ? "a" : "b") } label: {
            VStack(spacing: 0) {
                Text((m.server == team ? "● " : "") + (m.teams.indices.contains(team) ? m.teams[team] : ""))
                    .font(.caption2.bold()).lineLimit(1)
                Text(m.points[team]).font(.system(size: 40, weight: .heavy, design: .rounded))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(bg).foregroundStyle(fg)
        }
        .buttonStyle(.plain)
    }

    func load() async {
        do { m = try await ScoreAPI.fetch(pin: pin); error = nil }
        catch { if m == nil { self.error = error.localizedDescription } }
    }

    func act(_ action: String) {
        guard !busy else { return }
        busy = true
        WKInterfaceDevice.current().play(action == "undo" ? .retry : .click)
        Task {
            do { m = try await ScoreAPI.send(pin: pin, action: action) }
            catch { WKInterfaceDevice.current().play(.failure) }
            busy = false
        }
    }
}
