//
//  NewsAPIResponse.swift
//  News Crunch
//
//  Created by Jerry Leong on 30/09/2021.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
        
    let code: String?
    let message: String?
}
