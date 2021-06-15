//
//  EventCellViewModel.swift
//  42Events
//
//  Created by Phuc Nguyen on 05/06/2021.
//

import Foundation

struct TagViewModel {
    let imageName: String?
    let title: String
}

struct EventCellViewModel {
    let name: String
    let imageURL: URL?
    let isFreeEngraving: Bool
    let startDate: String
    let endDate: String
    let tags: [TagViewModel]
    
    init(race: Race, isMedal: Bool) {
        self.name = race.name
        self.imageURL = URL(string: isMedal ? race.medalImageURL : race.imageURL)
        self.isFreeEngraving = race.isFreeEngraving
        self.startDate = (Formatter.date(from: race.startDate) ?? Date()).toStartString()
        self.endDate = (Formatter.date(from: race.endDate) ?? Date()).toEndString()
        
        var tags: [TagViewModel] = []
        if let category = Category(rawValue: race.sportType) {
            tags.append(TagViewModel(imageName: "\(category.rawValue)-icon", title: category.displayName))
        }
        if race.raceRunners > 0 {
            tags.append(TagViewModel(imageName: nil, title: "\(race.raceRunners) joined"))
        }
        if let price = race.racePrice {
            tags.append(TagViewModel(imageName: nil, title: price))
        }
        if !race.eventType.isEmpty {
            tags.append(TagViewModel(imageName: nil, title: race.eventType))
        }
        tags.append(contentsOf: race.categories?.compactMap({ $0.isEmpty ? nil : TagViewModel(imageName: nil, title: $0) }) ?? [])
        self.tags = tags
    }
}
