//
//  SideMenuSection.swift
//  42Events
//
//  Created by Phuc Nguyen on 14/06/2021.
//

import Foundation
import RxDataSources

enum SideMenuSection {
    case menu(items: [SideMenuSectionItem])
}

enum SideMenuSectionItem {
    case text(viewModel: MenuItemViewModel)
    case switcher(viewModel: MenuItemViewModel)
}

extension SideMenuSection: SectionModelType {
    var items: [SideMenuSectionItem] {
        switch self {
        case .menu(let items):
            return items
        }
    }
    
    init(original: SideMenuSection, items: [SideMenuSectionItem]) {
        switch original {
        case .menu:
            self = .menu(items: items)
        }
    }
}
