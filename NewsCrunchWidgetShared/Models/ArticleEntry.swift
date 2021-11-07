//
//  ArticleEntry.swift
//  News Crunch
//
//  Created by Jerry Leong on 05/11/2021.
//  Copyright © 2021 Jerry Leong. All rights reserved.
//

import Foundation
import WidgetKit

struct ArticleEntry: TimelineEntry {
    
    enum State {
        case articles([ArticleWidgetModel])
        case failure(Error)
    }
    
    let date: Date
    let state: State
    let category: Category
    
}
