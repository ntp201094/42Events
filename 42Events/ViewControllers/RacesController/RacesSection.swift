//
//  RacesSection.swift
//  42Events
//
//  Created by Phuc Nguyen on 12/06/2021.
//

import Foundation
import RxDataSources

enum RacesSection {
    case races(title: String, items: [RacesSectionItem])
}

enum RacesSectionItem {
    case loading
    case race(viewModel: EventCellViewModel)
    case medalRace(viewModel: EventCellViewModel)
}

extension RacesSection: SectionModelType {
    var items: [RacesSectionItem] {
        switch self {
        case .races(_, let items):
            return items
        }
    }
    
    init(original: RacesSection, items: [RacesSectionItem]) {
        switch original {
        case .races(let title, _):
            self = .races(title: title, items: items)
        }
    }
}
