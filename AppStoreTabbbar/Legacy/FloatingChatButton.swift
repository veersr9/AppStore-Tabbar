import SwiftUI

struct FloatingChatButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                LiquidGlassBackground()
                    .clipShape(Circle())

                Image(systemName: "message.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(width: 66, height: 66)
            .contentShape(Circle())
        }
        .buttonStyle(.plain)
    }
}
