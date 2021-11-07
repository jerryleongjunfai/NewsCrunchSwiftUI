//
//  SettingsView.swift
//  News Crunch Mac
//
//  Created by Jerry Leong on 26/10/2021.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView{
            GeneralSettings()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
        }
        .frame(width: 400, height:  100, alignment: .center)
    }
    
    private struct GeneralSettings: View {
        
        @EnvironmentObject var searchVM: ArticleSearchViewModel
        @EnvironmentObject var bookmarkVM: ArticleBookmarkViewModel
        
        var body: some View {
            Form {
                VStack {
                    HStack {
                        Text("Search history data:")
                            .frame(width: 150, alignment: .trailing)
                        
                        Button("Clear All") {
                            searchVM.removeAllHistory()
                        }
                        .frame(alignment: .trailing)
                    }
                    
                    HStack {
                        Text("Saved bookmarks data:")
                            .frame(width: 150, alignment: .trailing)
                        
                        Button("Clear All") {
                            bookmarkVM.removeAllBookmarks()
                        }
                        .frame(alignment: .trailing)
                    }
                }
            }
            .fixedSize()
            .padding()
        }
    }
}

