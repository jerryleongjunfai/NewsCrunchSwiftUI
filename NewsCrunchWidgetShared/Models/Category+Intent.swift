//
//  Category+Intent.swift
//  News Crunch
//
//  Created by Jerry Leong on 05/11/2021.
//  Copyright © 2021 Jerry Leong. All rights reserved.
//

import Foundation

extension Category {
    init(_ categoryIntentParam: CategoryIntentParam) {
        switch categoryIntentParam {
        case.general: self = .general
        case.business: self = .business
        case.entertainment: self = .entertainment
        case.technology: self = .technology
        case.sports: self = .sports
        case.science: self = .science
        case.health: self = .health
        case.unknown: self = .general
        }
    }
}
