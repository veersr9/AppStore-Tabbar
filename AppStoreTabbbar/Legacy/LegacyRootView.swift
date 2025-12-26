import SwiftUI

/// Legacy demo: custom bubble tabbar + floating chat button.
/// Chat opens using `.fullScreenCover`.
struct LegacyRootView: View {
    @State private var selectedTab: Int = 0
    @State private var showChat: Bool = false

    var body: some View {
        ZStack {
            // Content
            Group {
                switch selectedTab {
                case 0: DemoScreen(title: "Home")
                case 1: DemoScreen(title: "Journey")
                case 2: DemoScreen(title: "Library")
                case 3: DemoScreen(title: "Profile")
                default: DemoScreen(title: "Home")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [Color(hex: "#0B1220"), Color(hex: "#151F33")],
                               startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            )

            // Bottom bar + floating chat
            VStack {
                Spacer()

                HStack(alignment: .bottom, spacing: 10) {
                    CustomTabBarView(selectedTab: $selectedTab, barHeight: 66)
                        .frame(height: 66)

                    FloatingChatButton {
                        showChat = true
                    }
                    .frame(width: 66, height: 66)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
        }
        .fullScreenCover(isPresented: $showChat) {
            ModernChatView()
        }
    }
}

private struct DemoScreen: View {
    let title: String
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.largeTitle.bold())
                .foregroundStyle(.white)

            Text("Legacy demo content")
                .foregroundStyle(.white.opacity(0.75))
        }
    }
}
