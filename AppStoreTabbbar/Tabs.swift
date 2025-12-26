import SwiftUI

// MARK: - Tabs

enum DemoTab: Int, CaseIterable, Identifiable, Hashable {
    case home
    case journey
    case library
    case profile

    /// Action tab (doesn't navigate) – opens chat
    case chatAction

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .home: return "Home"
        case .journey: return "Journey"
        case .library: return "Library"
        case .profile: return "Profile"
        case .chatAction: return "More"
        }
    }

    /// SF Symbol (easy demo). Replace with your asset names if needed.
    var systemImage: String {
        switch self {
        case .home: return "house.fill"
        case .journey: return "map.fill"
        case .library: return "books.vertical.fill"
        case .profile: return "person.crop.circle.fill"
        case .chatAction: return "message.fill"
        }
    }
}
