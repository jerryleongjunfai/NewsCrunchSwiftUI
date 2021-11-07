//
//  ArticleDataStore.swift
//  NewsCrunchWatch WatchKit Extension
//
//  Created by Jerry Leong on 28/10/2021.
//

import Foundation

private let LastArticleKey = "LastArticleKey"

struct ArticleDataStore {
    
    private let defaults = UserDefaults.standard
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()

    var lastArticle: Article? {
        get {
            guard let data = defaults.data(forKey: LastArticleKey),
                  let article = try? jsonDecoder.decode(Article.self, from: data)
            else {
                return nil
            }
            return article
        }
        
        set {
            guard let value = newValue,
                  let data = try? jsonEncoder.encode(value)
            else {
                return
            }
            defaults.set(data, forKey: LastArticleKey)
        }
    }
}
