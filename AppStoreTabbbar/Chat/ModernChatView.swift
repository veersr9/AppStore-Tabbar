import SwiftUI

struct ModernChatView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.black.opacity(0.9), Color.black.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                HStack {
                    Button("Close") { dismiss() }
                        .font(.headline)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())

                    Spacer()

                    Text("ModernChatView")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Spacer()

                    // placeholder to keep title centered
                    Color.clear.frame(width: 64, height: 1)
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)

                Spacer()

                VStack(spacing: 10) {
                    Text("This is a sample chat screen.")
                        .foregroundStyle(.white.opacity(0.9))
                    Text("Opened via fullScreenCover.")
                        .foregroundStyle(.white.opacity(0.7))
                }

                Spacer()
            }
        }
    }
}
