//
//  RetryView.swift
//  News Crunch
//
//  Created by Jerry Leong on 01/10/2021.
//

import SwiftUI

struct RetryView: View {
    
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 8){
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction){
                Text("Try again ☹️")
            }
        }
    }
}

struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(text: "An error occured"){}
    }
}
