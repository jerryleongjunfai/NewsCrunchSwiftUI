//
//  SidebarContentView.swift
//  News Crunch
//
//  Created by Jerry Leong on 03/10/2021.
//

import SwiftUI

struct SidebarContentView: View {
    
    @Binding var selectedMenuItemId: MenuItem.ID?
    private var selection: Binding<MenuItem.ID?>{
        Binding{
            selectedMenuItemId ?? MenuItem.category(.general).id
        } set: { newValue in
            if let menuItemId = newValue {
                selectedMenuItemId = menuItemId
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                navigationLink
                List(selection: selection) {
                        ForEach([MenuItem.saved, MenuItem.search]){
                            listRow($0)
                        }
                        Section{
                            ForEach(Category.menuItems){
                                listRow($0)
                            }
                        } header: {
                            Text("Categories")
                        }
                        .navigationTitle("News Crunch")
                    }
                .listStyle(.sidebar)
            }
        }
    }
    private func navigationLinkForMenuItem(_ item: MenuItem) -> some View {
        NavigationLink(destination: viewForMenuItem(item: item),tag: item.id, selection: selection) {
            Label(item.text, systemImage: item.systemImage)
        }
    }
    
    @ViewBuilder
    private func listRow(_ item: MenuItem) -> some View {
        let isSelected = item.id == selection.wrappedValue
        Button{
            self.selection.wrappedValue = item.id
        }label: {
            Label(item.text, systemImage: item.systemImage)
        }
        .foregroundColor(isSelected ? Color.white : nil)
        .listRowBackground((isSelected ? Color.accentColor : Color.clear).mask(RoundedRectangle(cornerRadius: 8)))
    }
    
    @ViewBuilder
        private var navigationLink: some View {
            if let selectedMenuItem = MenuItem(id: selection.wrappedValue){
            NavigationLink(
                destination: viewForMenuItem(item: selectedMenuItem).environmentObject(ArticleBookmarkViewModel.shared),
                tag: selectedMenuItem.id,
                    selection: selection) {
                    EmptyView()
            }
        }
    }
    
    @ViewBuilder
    private func viewForMenuItem(item: MenuItem) -> some View {
        switch item {
        case .search:
            SearchTabView()
        case .saved:
            BookmarkTabView()
        case .category(let category):
            NewsTabView(category: category)
                .id(category.id)
        }
    }
}

struct SidebarContentView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarContentView(selectedMenuItemId: .constant(nil))
    }
}
