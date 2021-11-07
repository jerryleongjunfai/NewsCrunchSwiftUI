//
//  NewsCommands.swift
//  News Crunch Mac
//
//  Created by Jerry Leong on 26/10/2021.
//


import SwiftUI

struct NewsCommands: Commands {
    
    var body: some Commands {
        CommandGroup(before: .sidebar) {
            BodyView()
                .keyboardShortcut("R", modifiers: [.command])
        }
    }
    
    struct BodyView: View {
        
        @FocusedValue(\.refreshAction) private var refreshAction: (() -> Void)?
        
        var body: some View {
            Button("Refresh News") {
                refreshAction?()
            }
        }
        
    }
    
}
