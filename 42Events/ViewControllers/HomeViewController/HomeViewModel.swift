//
//  HomeViewModel.swift
//  42Events
//
//  Created by Phuc Nguyen on 29/05/2021.
//

import Foundation
import RxSwift
import RxCocoa

enum HomeViewModel: ViewModelType {
    struct Inputs {
        let menuButtonPressed: Observable<Void>
        let categoryItemSelected: Observable<CategoryCellViewModel>
    }
    
    struct Outputs {
        let sections: Observable<[HomeSection]>
    }
    
    enum Action {
        case openMenu
        case openRaces(category: Category)
    }
    
    static func viewModel() -> (Inputs) -> (Outputs, Driver<Action>) {
        return { inputs in
            
            let response = Observable.just(())
                .flatMapLatest({
                    URLSession.shared.rx.dataTask(with: Requests.dashboard.urlRequest)
                })
                .share(replay: 1)
            
            let sections = response
                .compactMap { $0.success }
                .map({ data -> [HomeSection] in
                    let dashboard = try JSONDecoder().decode(ServerResponse<Dashboard>.self, from: data).data
                    let featuredViewModel = HomeCarouselCellViewModel(
                        imageURLs: dashboard.featured.compactMap({ URL(string: $0.imageURL) })
                    )
                    
                    let categoriesViewModel = HomeCategoriesCellViewModel(categories: Category.allCases)
                    let startingSoonViewModel = HomeEventsCellViewModel(races: dashboard.startingSoon)
                    let popularViewModel = HomeEventsCellViewModel(races: dashboard.popular)
                    let newReleasesViewModel = HomeEventsCellViewModel(races: dashboard.newRelease)
                    let freeViewModel = HomeEventsCellViewModel(races: dashboard.free)
                    let pastEventsViewModel = HomeEventsCellViewModel(races: dashboard.past)
                    
                    return [
                        .carousel(item: HomeSectionItem.carousel(viewModel: featuredViewModel)),
                        .categories(item: HomeSectionItem.categories(viewModel: categoriesViewModel)),
                        .events(title: "Starting soon", item: HomeSectionItem.events(viewModel: startingSoonViewModel)),
                        .events(title: "Popular", item: HomeSectionItem.events(viewModel: popularViewModel)),
                        .events(title: "New releases", item: HomeSectionItem.events(viewModel: newReleasesViewModel)),
                        .events(title: "Free", item: HomeSectionItem.events(viewModel: freeViewModel)),
                        .events(title: "Past Events", item: HomeSectionItem.events(viewModel: pastEventsViewModel))
                    ]
                })
            
            let openMenu = inputs.menuButtonPressed
                .asDriver(onErrorJustReturn: ())
                .map { Action.openMenu }
            
            let openCategory = inputs.categoryItemSelected
                .asDriver(onErrorJustReturn: CategoryCellViewModel(category: .running))
                .map { Action.openRaces(category: $0.category) }
            
            return (
                Outputs(
                    sections: sections
                ),
                Driver.merge(openMenu, openCategory)
            )
        }
    }
}
