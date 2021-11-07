//
//  NewsCrunchTVApp.swift
//  NewsCrunchTV
//
//  Created by Jerry Leong on 29/10/2021.
//

import SwiftUI

@main
struct NewsCrunchTVApp: App {
    
    @StateObject private var bookmarkVM = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(bookmarkVM)
        }
    }
}
