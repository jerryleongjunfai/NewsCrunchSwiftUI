//
//  NewsCrunchiOSWidget.swift
//  NewsCrunchiOSWidget
//
//  Created by Jerry Leong on 04/11/2021.
//  Copyright © 2021 Jerry Leong. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct NewsCrunchiOSWidget: Widget {
    let kind: String = "NewsCrunchiOSWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectCategoryIntent.self, provider: ArticleProvider()) { entry in
            ArticleEntryWidgetView(entry: entry)
        }
        .configurationDisplayName("Latest News")
        .description("Display the latest news.")
    }
}
