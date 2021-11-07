//
//  Stub.swift
//  News Crunch
//
//  Created by Jerry Leong on 05/11/2021.
//  Copyright © 2021 Jerry Leong. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension ArticleWidgetModel {
    static var stubImageData: Data {
        #if os(macOS)
        NSImage(named: "placeholder")!.tiffRepresentation!
        #else
        UIImage(named: "placeholder")!.jpegData(compressionQuality: 0.7)!
        #endif
    }
    
    static var stubArticleWithImageData: ArticleWidgetModel {
        .init(state: .article(article: Article.previewData[0], imageData: ArticleWidgetModel.stubImageData))
    }
    
    static var stubs: [ArticleWidgetModel] {
        Article.previewData.map { article -> ArticleWidgetModel in
                .init(state: .article(article: article, imageData: ArticleWidgetModel.stubImageData))
        }
    }
    
    static var placeholders: [ArticleWidgetModel] {
        (0..<5).map { (_) -> ArticleWidgetModel in
                .init(state: .placeholder)
        }
    }
}

extension ArticleEntry {
    static var placholder: ArticleEntry {
        ArticleEntry(date: Date(), state: .articles(ArticleWidgetModel.placeholders), category: .entertainment)
    }
    
    static var stubArticles: ArticleEntry {
        ArticleEntry(date: Date(), state: .articles(ArticleWidgetModel.stubs), category: .general)
    }
}
