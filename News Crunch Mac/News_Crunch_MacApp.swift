//
//  News_Crunch_MacApp.swift
//  News Crunch Mac
//
//  Created by Jerry Leong on 26/10/2021.
//

import SwiftUI
import AppKit
import WidgetKit

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func application(_ application: NSApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([NSUserActivityRestoring]) -> Void) -> Bool {
        if let urlString = userActivity.userInfo?[activityURLKey] as? String,
           let url = URL(string: urlString) {
            NSWorkspace.shared.open(url)
        }
        return true
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        if let url = urls.first {
            NSWorkspace.shared.open(url)
        }
    }
}

@main
struct News_Crunch_MacApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @StateObject private var bookmarkVM: ArticleBookmarkViewModel = ArticleBookmarkViewModel.shared
    @StateObject private var searchVM: ArticleSearchViewModel = ArticleSearchViewModel.shared

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkVM)
                .environmentObject(searchVM)
        }
        .handlesExternalEvents(matching: [])
        
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem){}
            SidebarCommands()
            NewsCommands()
        }
        
        Settings {
            SettingsView()
                .environmentObject(bookmarkVM)
                .environmentObject(searchVM)
        }
    }
}
