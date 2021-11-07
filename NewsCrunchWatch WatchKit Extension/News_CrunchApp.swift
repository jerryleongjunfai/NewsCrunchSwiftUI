//
//  News_CrunchApp.swift
//  NewsCrunchWatch WatchKit Extension
//
//  Created by Jerry Leong on 27/10/2021.
//

import SwiftUI
import WatchKit

@main
struct News_CrunchApp: App {
    
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) private var extensionDelegate
    @StateObject private var bookmarkVM = ArticleBookmarkViewModel.shared
    @StateObject private var searchVM = ArticleSearchViewModel.shared
    @StateObject private var connectivityVM = WatchConnectivityViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(bookmarkVM)
            .environmentObject(searchVM)
            .environmentObject(connectivityVM)
        }
    }
}
