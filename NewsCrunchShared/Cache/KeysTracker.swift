//
//  KeysTracker.swift
//  News Crunch
//
//  Created by Jerry Leong on 02/11/2021.
//

import Foundation

final class KeysTracker<V>: NSObject, NSCacheDelegate {
    
    var keys = Set<String>()
    
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        guard let entry = obj as? CacheEntry<V> else {
            return
        }
        keys.remove(entry.key)
    }
}
