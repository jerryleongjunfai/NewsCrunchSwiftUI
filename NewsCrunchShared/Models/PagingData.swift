//
//  PagingData.swift
//  News Crunch
//
//  Created by Jerry Leong on 03/11/2021.
//

import Foundation

actor PagingData {
    
    private(set) var currentPage = 0
    private(set) var hasReachedEnd = false
    
    let itemsPerPage: Int
    let maxPageLimit: Int
    
    init(itemsPerPage: Int, maxPageLimit: Int) {
        assert(itemsPerPage > 0 && maxPageLimit > 0, "Items per page and max page limit must be greater than zero")
        self.itemsPerPage = itemsPerPage
        self.maxPageLimit = maxPageLimit
    }
    
    var nextPage: Int { currentPage + 1 }
    var shouldLoadNextPage: Bool {
        !hasReachedEnd && nextPage <= maxPageLimit
    }
    
    func loadNextPage<T>(dataFetchProvider: @escaping (Int) async throws -> [T]) async throws -> [T] {
        if Task.isCancelled { return [] }
        print("PAGING: Current Page \(currentPage), next page: \(nextPage)")
        
        guard shouldLoadNextPage else { return [] }
        
        let nextPage = self.nextPage
        let items = try await dataFetchProvider(nextPage)
        
        if Task.isCancelled || nextPage != self.nextPage {
            return []
        }
        
        currentPage = nextPage
        hasReachedEnd = items.count < itemsPerPage
        
        print("PAGING: fetch \(items.count) item(s) successfully. Current page: \(currentPage)")
        
        return items
        
    }
    
    func reset() {
        print("PAGING: RESET")
        currentPage = 0
        hasReachedEnd = false
    }
    
}
