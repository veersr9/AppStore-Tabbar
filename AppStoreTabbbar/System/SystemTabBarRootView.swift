import SwiftUI

/// iOS 26 System TabBar demo:
/// - Uses `TabView` with iOS 26 `Tab(value:)` API.
/// - The last tab acts like an action button: it opens chat via `fullScreenCover` and reverts selection.
/// NOTE: This file requires iOS 26 SDK.
@available(iOS 26.0, *)
struct SystemTabBarRootView: View {

    private let tabs: [DemoTab] = [.home, .journey, .library, .profile, .chatAction]

    @State private var selected: DemoTab = .home
    @State private var showChat: Bool = false

    var body: some View {
        ZStack {
            TabView(selection: $selected) {
                ForEach(tabs) { tab in
                    if tab == .chatAction {
                        // Action tab - doesn't have real content
                        Tab(value: tab, role: .search) {
                            Color.clear
                        } label: {
                            Image(systemName: tab.systemImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 19, height: 19) // 5px smaller than 24
                            Text(tab.title)
                        }
                    } else {
                        Tab(value: tab) {
                            DemoTabContent(tab: tab)
                        } label: {
                            Image(systemName: tab.systemImage)
                            Text(tab.title)
                        }
                    }
                }
            }
            .tint(Color(hex: "#58AEA4"))
            .tabBarMinimizeBehavior(.onScrollDown)

            // Handle action tab selection: open chat and revert
            .onChange(of: selected) { oldValue, newValue in
                if newValue == .chatAction {
                    showChat = true
                    selected = oldValue
                }
            }
        }
        .fullScreenCover(isPresented: $showChat) {
            ModernChatView()
        }
    }
}

@available(iOS 26.0, *)
private struct DemoTabContent: View {
    let tab: DemoTab

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(hex: "#0B1220"), Color(hex: "#151F33")],
                           startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()

            VStack(spacing: 12) {
                Image(systemName: tab.systemImage)
                    .font(.system(size: 44, weight: .bold))
                    .foregroundStyle(.white)

                Text(tab.title)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                Text("iOS 26 System TabBar demo")
                    .foregroundStyle(.white.opacity(0.7))
            }
        }
    }
}
