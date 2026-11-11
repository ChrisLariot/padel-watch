import SwiftUI

/// Tap a digit to select it, turn the Digital Crown to change it.
struct PinEntryView: View {
    @State private var digits = [0, 0, 0, 0]
    @State private var pos = 0
    @State private var crown = 0.0
    @State private var go = false

    var pin: String { digits.map(String.init).joined() }

    var body: some View {
        VStack(spacing: 6) {
            Text("PADEL SCORE").font(.caption2.bold()).foregroundStyle(Brand.orange)
            Text("Court PIN").font(.headline).foregroundStyle(Brand.cream)
            HStack(spacing: 4) {
                ForEach(0..<4, id: \.self) { i in
                    Text("\(digits[i])")
                        .font(.system(size: 28, weight: .heavy, design: .rounded))
                        .frame(maxWidth: .infinity, minHeight: 46)
                        .background(i == pos ? Brand.orange : Brand.navy2)
                        .foregroundStyle(i == pos ? .white : Brand.cream)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onTapGesture { pos = i; crown = Double(digits[i]) }
                }
            }
            .focusable()
            .digitalCrownRotation($crown, from: 0, through: 9, by: 1, sensitivity: .low, isContinuous: true)
            .onChange(of: crown) { v in
                digits[pos] = ((Int(v.rounded()) % 10) + 10) % 10
            }
            Button(pos < 3 ? "Next" : "Join") {
                if pos < 3 { pos += 1; crown = Double(digits[pos]) } else { go = true }
            }
            .tint(Brand.orange)
        }
        .padding(.horizontal, 4)
        .background(Brand.navy.ignoresSafeArea())
        .navigationDestination(isPresented: $go) { ScoreView(pin: pin) }
    }
}
