# JoyScore Tabbar + Floating Chat (Sample)

This is a **copy‑paste friendly** sample you can share with other developers to quickly reproduce:

- A **legacy custom “bubble” tab bar** with a **floating chat button**
- A **chat screen opened via `fullScreenCover`** (no `NavigationDestination`)
- An **iOS 26 System TabBar** demo where the last “More/Chat” tab **does not switch tabs** and instead opens chat.

## How to use (fastest)
1) In Xcode, create a new project: **iOS > App > SwiftUI** (e.g. name: `JoyScoreTabbarChatSample`)
2) Delete the default `ContentView.swift` & `YourAppNameApp.swift`
3) Copy the files from this folder into your project target.

## Replace with your icons/titles
This demo uses **SF Symbols**.  
To use your assets (`ic_HomeNew`, `ic_JourneyNew`, etc.), open:
- `Tabs.swift` and replace `systemImage` with `assetName` usage in the UI.

## iOS 26 notes
`SystemTabBarRootView.swift` uses **iOS 26-only APIs** (like `Tab(...)`, `tabBarMinimizeBehavior`).
- Compile this demo with Xcode/iOS SDK that includes iOS 26.
- If your teammate doesn’t have iOS 26 SDK, they can temporarily remove `SystemTabBarRootView.swift` from the target and use the legacy demo.

## What to show in code review
- `LegacyRootView` → custom bubble tab bar + floating chat
- `SystemTabBarRootView` → iOS 26 TabView + “More/Chat” action tab opens chat

