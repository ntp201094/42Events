//
//  HomeSection.swift
//  42Events
//
//  Created by Phuc Nguyen on 29/05/2021.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

enum HomeSection {
    case loading
    case carousel(item: HomeSectionItem)
    case categories(item: HomeSectionItem)
    case events(title: String, item: HomeSectionItem)
}

enum HomeSectionItem {
    case loading
    case carousel(viewModel: HomeCarouselCellViewModel)
    case categories(viewModel: HomeCategoriesCellViewModel)
    case events(viewModel: HomeEventsCellViewModel)
}

extension HomeSection: SectionModelType {
    var items: [HomeSectionItem] {
        switch self {
        case .loading:
            return [.loading]
        case .carousel(let item):
            return [item]
        case .categories(let item):
            return [item]
        case let .events(_, item):
            return [item]
        }
    }
    
    init(original: HomeSection, items: [HomeSectionItem]) {
        switch original {
        case .loading:
            self = .loading
        case .carousel:
            self = .carousel(item: items.first!)
        case .categories:
            self = .categories(item: items.first!)
        case .events(let title, _):
            self = .events(title: title, item: items.first!)
        }
    }
}
