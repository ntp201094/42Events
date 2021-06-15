//
//  Language.swift
//  42Events
//
//  Created by Phuc Nguyen on 10/06/2021.
//

import Foundation

enum Language {
    case english
    case vietnamese
    
    var displayName: String {
        switch self {
        case .english:
            return "English"
        case .vietnamese:
            return "Tiếng Việt"
        }
    }
}
