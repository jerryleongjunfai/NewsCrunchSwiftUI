//
//  SettingsView.swift
//  NewsCrunchWatch WatchKit Extension
//
//  Created by Jerry Leong on 28/10/2021.
//

import SwiftUI

let complicationCategoryKey = "selected_complication_category"

struct SettingsView: View {
    
    @EnvironmentObject private var bookmarkVM: ArticleBookmarkViewModel
    @AppStorage(complicationCategoryKey) private var _selectedCategory: String?
    
    private var selectedCategory: Binding<Category> {
        Binding {
            Category(rawValue: _selectedCategory ?? Category.general.rawValue) ??
                .general
        } set: { newValue in
            _selectedCategory = newValue.rawValue
        }
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Category", selection: selectedCategory) {
                    ForEach(Category.allCases) {
                        Text($0.text).tag($0)
                    }
                }
            } header: {
                Text("Complication")
            } footer: {
                Text("Set category of news used for refreshing complication data")
            }

            if !bookmarkVM.bookmarks.isEmpty {
                Section {
                    Button(role: .destructive) {
                        bookmarkVM.removeAllBookmarks()
                    } label: {
                        Text("Clear All")
                    }

                } header: {
                    Text("Saved bookmarks data")
                } footer: {
                    Text("Clearing will remove all your saved articles list data")
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
