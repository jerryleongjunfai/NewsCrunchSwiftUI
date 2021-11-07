//
//  Category.swift
//  News Crunch
//
//  Created by Jerry Leong on 01/10/2021.
//

import Foundation

enum Category: String, CaseIterable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
    
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
    
    var systemImage: String {
        switch self {
        case .general:
            return "newspaper"
        case .business:
            return "building.2"
        case .technology:
            return "iphone"
        case .entertainment:
            return "tv"
        case .sports:
            return "sportscourt"
        case .science:
            return "leaf"
        case .health:
            return "cross"
        }
    }
    
    var sortIndex: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
}

extension Category: Identifiable {
    var id: Self { self }
}
