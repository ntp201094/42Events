//
//  MenuItemViewModel.swift
//  42Events
//
//  Created by Phuc Nguyen on 10/06/2021.
//

import Foundation

enum MenuItem: CaseIterable {
    static var allCases: [MenuItem] = [
        .logIn,
        .signUp,
        .guidesFAQ,
        .contactUs,
        .language(selected: .english),
        .modeSwitcher
    ]
    
    case logIn
    case signUp
    case guidesFAQ
    case contactUs
    case language(selected: Language)
    case modeSwitcher
    
    var imageName: String {
        switch self {
        case .logIn:
            return "login"
        case .signUp:
            return "edit"
        case .guidesFAQ:
            return "guides"
        case .contactUs:
            return "contact"
        case .language:
            return "language"
        case .modeSwitcher:
            return "moon.stars.fill"
        }
    }
    
    var title: String {
        switch self {
        case .logIn:
            return "Log in"
        case .signUp:
            return "Sign up"
        case .guidesFAQ:
            return "Guides and FAQ"
        case .contactUs:
            return "Contact us"
        case .language:
            return "Language"
        case .modeSwitcher:
            return "Dark mode:"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .language(let selected):
            return selected.displayName
        default:
            return nil
        }
    }
}

struct MenuItemViewModel {
    let item: MenuItem
}
