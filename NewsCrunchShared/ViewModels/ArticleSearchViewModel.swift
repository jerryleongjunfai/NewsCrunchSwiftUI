//
//  ArticleSearchViewModel.swift
//  News Crunch
//
//  Created by Jerry Leong on 02/10/2021.
//

import Combine
import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    @Published var history = [String]()
    @Published var currentSearch: String?
    private let historyDataStore = PlistDataStore<[String]>(filename: "histories")
    private let historyMaxLimit = 10
    
    private var cancellables = Set<AnyCancellable>()
    
    private let newsAPI = NewsAPI.shared
    
    static let shared = ArticleSearchViewModel()
    
    private init(){
        load()
        #if os(tvOS)
        observeSearchQuery()
        #endif
    }
    
    private func observeSearchQuery() {
        $searchQuery
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { _ in
                Task { [weak self] in
                    guard let self = self else { return }
                    await self.searchArticle()
                }
            }
            .store(in: &cancellables)
    }
    
    private var trimmedSearchQuery: String {
        searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func addHistory(_ text: String){
        if let index = history.firstIndex(where: { text.lowercased() == $0.lowercased() }) {
            history.remove(at: index)
        } else if history.count == historyMaxLimit {
            history.remove(at: -1)
        }
        
        history.insert(text, at: 0)
        historiesUpdated()
    }
    
    func removeHistory(_ text: String){
        guard let index = history.firstIndex(where: { text.lowercased() == $0.lowercased() })
        else {
            return
        }
        history.remove(at: index)
        historiesUpdated()
    }
    
    func removeAllHistory() {
        history.removeAll()
        historiesUpdated()
    }
    
    func searchArticle() async {
        if Task.isCancelled { return }
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        currentSearch = searchQuery
        do{
            let articles = try await newsAPI.search(for: searchQuery)
            if Task.isCancelled { return }
            if searchQuery != self.searchQuery {
                return
            }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            if searchQuery != self.searchQuery {
                return
            }
            phase = .failure(error)
        }
    }
    private func load() {
        Task {
            self.history = await historyDataStore.load() ?? []
        }
    }
    private func historiesUpdated() {
        let history = self.history
        Task {
            await historyDataStore.save(history)
        }
    }
}
