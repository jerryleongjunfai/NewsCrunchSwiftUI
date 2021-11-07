//
//  ArticleNewsViewModel.swift
//  News Crunch
//
//  Created by Jerry Leong on 01/10/2021.
//

import Foundation
import SwiftUI

struct FetchTaskToken: Equatable {
    var category: Category
    var token: Date
}

fileprivate let dateFormatter = DateFormatter()

@MainActor
class ArticleNewsViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken {
        didSet {
            if oldValue.category != fetchTaskToken.category {
                selectedMenuItemId = MenuItem.category(fetchTaskToken.category).id
            }
        }
    }
    @AppStorage("item_selection") private var selectedMenuItemId: MenuItem.ID?
    //private let cache = InMemoryCache<[Article]>(expirationInterval: 2 * 60)
    private let cache = DiskCache<[Article]>(filename: "news_crunch_articles", expirationInterval: 3 * 60)

    private let newsAPI = NewsAPI.shared
    private let pagingData = PagingData(itemsPerPage: 10, maxPageLimit: 5)
    
    var lastRefreshedDateText: String {
        dateFormatter.timeStyle = .short
        return "Last refreshed at: \(dateFormatter.string(from: fetchTaskToken.token))"
    }
    
    var articles: [Article] {
        phase.value ?? []
    }
    
    var isFetchingNextPage: Bool {
        if case .fetchingNextPage = phase {
            return true
        }
        return false
    }
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
        
        Task(priority: .userInitiated) {
            try? await cache.loadFromDisk()
        }
    }
    
    func refreshTask() async {
        await cache.removeValue(forKey: fetchTaskToken.category.rawValue)
        fetchTaskToken.token = Date()
    }
    
    func loadFirstPage() async {
        if Task.isCancelled { return }
        
        let category = fetchTaskToken.category
        if let articles = await cache.value(forKey: category.rawValue) {
            phase = .success(articles)
            print("CACHE HIT")
            return
        }
        
        print("CACHE MISSED/EXPIRED")
        
        phase = .empty
        do {
            await pagingData.reset()
            let articles = try await pagingData.loadNextPage(dataFetchProvider: loadArticles(page:))
            if Task.isCancelled { return }
            await cache.setValue(articles, forKey: category.rawValue)
            try? await cache.saveToDisk()
            print("CACHE SET")
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
    
    func loadNextPage() async {
        if Task.isCancelled { return }
        
        let articles = self.phase.value ?? []
        phase = .fetchingNextPage(articles)
        
        do {
            let nextArticles = try await pagingData.loadNextPage(dataFetchProvider: loadArticles(page:))
            if Task.isCancelled { return }
            
            phase = .success(articles + nextArticles)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadArticles(page: Int) async throws -> [Article] {
        let articles = try await newsAPI.fetch(from: fetchTaskToken.category, page: page, pageSize: pagingData.itemsPerPage)
        if Task.isCancelled { return [] }
        return articles
    }
}
