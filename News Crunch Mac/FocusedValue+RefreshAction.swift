//
//  FocusedValue+RefreshAction.swift
//  News Crunch Mac
//
//  Created by Jerry Leong on 26/10/2021.
//

import SwiftUI

fileprivate var _refreshAction: (() -> Void)?

extension FocusedValues {
    
    var refreshAction: (() -> Void)? {
        get {
//            self[RefreshActionKey.self]
            _refreshAction
        }
        
        set {
//            self[RefreshActionKey.self] = newValue
            _refreshAction = newValue
        }
        
    }
    
    struct RefreshActionKey: FocusedValueKey {
        typealias Value = () -> Void
    }
    
}
