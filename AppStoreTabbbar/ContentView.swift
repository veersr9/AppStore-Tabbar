//
//  ContentView.swift
//  AppStoreTabbbar
//
//  Created by Apple on 26/12/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        Group {
            // If your team has iOS 26 SDK, this shows the system tab bar demo.
            if #available(iOS 26.0, *) {
                SystemTabBarRootView()
            } else {
                LegacyRootView()
            }
        }
    }
}
