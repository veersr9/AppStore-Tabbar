import SwiftUI

/// Custom bubble tab bar (no extra width / no edge padding).
struct CustomTabBarView: View {

    @Binding var selectedTab: Int
    let barHeight: CGFloat

    private struct TabItem {
        let title: String
        let systemImage: String
    }

    private let tabs: [TabItem] = [
        TabItem(title: "Home", systemImage: "house.fill"),
        TabItem(title: "Journey", systemImage: "map.fill"),
        TabItem(title: "Library", systemImage: "books.vertical.fill"),
        TabItem(title: "Profile", systemImage: "person.crop.circle.fill")
    ]

    @State private var dragOffsetX: CGFloat?
    @State private var bubbleIsHeld = false
    @State private var bubbleIsBouncing = false

    init(selectedTab: Binding<Int>, barHeight: CGFloat = 66) {
        self._selectedTab = selectedTab
        self.barHeight = barHeight
    }

    var body: some View {
        GeometryReader { proxy in
            let barWidth = proxy.size.width
            let count = CGFloat(tabs.count)

            let itemWidth = barWidth / count
            let bubbleWidth = itemWidth
            let bubbleHeight = barHeight

            let baseOffset = clampX(
                itemWidth * CGFloat(selectedTab),
                minX: 0,
                maxX: barWidth - bubbleWidth
            )

            let bubbleOffset = dragOffsetX ?? baseOffset
            let bubbleScale = bubbleIsHeld ? 1.06 : (bubbleIsBouncing ? 1.03 : 1.0)
            let bubbleY: CGFloat = bubbleIsBouncing ? -2 : 0

            ZStack(alignment: .leading) {

                // Background bar
                LiquidGlassBackground()
                    .clipShape(RoundedRectangle(cornerRadius: barHeight / 2, style: .continuous))
                    .frame(width: barWidth, height: barHeight)

                // Sliding bubble
                LiquidGlassBackground()
                    .clipShape(RoundedRectangle(cornerRadius: bubbleHeight / 2, style: .continuous))
                    .frame(width: bubbleWidth, height: bubbleHeight)
                    .offset(x: bubbleOffset, y: bubbleY)
                    .scaleEffect(bubbleScale)
                    .animation(.interactiveSpring(response: 0.28, dampingFraction: 0.86),
                               value: bubbleOffset)
                    .allowsHitTesting(false)
                    .zIndex(2)

                // Tab items
                HStack(spacing: 0) {
                    ForEach(tabs.indices, id: \.self) { index in
                        tabButton(tabs[index], index: index, width: itemWidth, isSelected: selectedTab == index)
                    }
                }
                .frame(width: barWidth, height: barHeight)
                .zIndex(3)
            }
            .gesture(
                DragGesture(minimumDistance: 6)
                    .onChanged { value in
                        bubbleIsHeld = true
                        dragOffsetX = dragX(fingerX: value.location.x,
                                            barWidth: barWidth,
                                            bubbleWidth: bubbleWidth)
                    }
                    .onEnded { _ in
                        let finalOffset = dragOffsetX ?? baseOffset
                        let newIndex = tabIndex(for: finalOffset,
                                                bubbleWidth: bubbleWidth,
                                                itemWidth: itemWidth)

                        withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                            selectedTab = newIndex
                            dragOffsetX = nil
                        }

                        bubbleIsHeld = false
                        triggerBubbleBounce()
                    }
            )
        }
        .frame(height: barHeight)
    }

    private func tabButton(_ tab: TabItem, index: Int, width: CGFloat, isSelected: Bool) -> some View {
        VStack(spacing: 2) {
            Image(systemName: tab.systemImage)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(isSelected ? Color(hex: "#58AEA4") : .white)

            Text(tab.title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(isSelected ? Color(hex: "#58AEA4") : .white.opacity(0.95))
        }
        .frame(width: width, height: barHeight)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                selectedTab = index
            }
            dragOffsetX = nil
            triggerBubbleBounce()
        }
    }

    private func dragX(fingerX: CGFloat, barWidth: CGFloat, bubbleWidth: CGFloat) -> CGFloat {
        let desired = fingerX - bubbleWidth / 2
        return clampX(desired, minX: 0, maxX: barWidth - bubbleWidth)
    }

    private func tabIndex(for offset: CGFloat, bubbleWidth: CGFloat, itemWidth: CGFloat) -> Int {
        let center = offset + bubbleWidth / 2
        let idx = Int(center / itemWidth)
        return min(max(idx, 0), tabs.count - 1)
    }

    private func clampX(_ x: CGFloat, minX: CGFloat, maxX: CGFloat) -> CGFloat {
        let hi = max(maxX, minX)
        return min(max(x, minX), hi)
    }

    private func triggerBubbleBounce() {
        withAnimation(.spring(response: 0.22, dampingFraction: 0.6)) {
            bubbleIsBouncing = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                bubbleIsBouncing = false
            }
        }
    }
}
