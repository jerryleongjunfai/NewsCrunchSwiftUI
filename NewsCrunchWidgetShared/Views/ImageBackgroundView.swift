//
//  ImageBackgroundView.swift
//  News Crunch
//
//  Created by Jerry Leong on 06/11/2021.
//  Copyright © 2021 Jerry Leong. All rights reserved.
//

import SwiftUI
import WidgetKit
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

struct ImageBackgroundView: View {
    
    let data: Data?
    
    private var image: Image? {
        if let data = data {
            #if os(macOS)
            if let image = NSImage(data: data) {
                return Image(nsImage: image)
            }
            #else
            if let image = UIImage(data: data) {
                return Image(uiImage: image)
            }
            #endif
        }
        return nil
    }
    
    var body: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFill()
                .layoutPriority(-1)
                .clipped()
        } else {
            Color.accentColor
        }
    }
}

struct ImageBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ImageBackgroundView(data: ArticleWidgetModel.stubImageData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            ImageBackgroundView(data: nil)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
