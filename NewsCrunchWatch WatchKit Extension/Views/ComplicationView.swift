//
//  ComplicationView.swift
//  News Crunch
//
//  Created by Jerry Leong on 28/10/2021.
//

import SwiftUI
import ClockKit

struct ComplicationView: View {
    
    var text = ""
    
    var body: some View {
        Text(text)
            .font(.caption2)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ComplicationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CLKComplicationTemplateGraphicRectangularLargeView(
                headerTextProvider: CLKTextProvider(format: "News Crunch", []),
                content: ComplicationView(text: "Apple announced watchOS 8 at WWDC 2021")
            ).previewContext()
        }
    }
}
