//
//  DataFetchPhase.swift
//  News Crunch
//
//  Created by Jerry Leong on 29/10/2021.
//

import Foundation

enum DataFetchPhase<T> {
    
    case empty
    case success(T)
    case fetchingNextPage(T)
    case failure(Error)
    
    var value: T? {
        if case .success(let value) = self {
            return value
        } else if case .fetchingNextPage(let value) = self {
            return value
        }
        return nil
    }
}
