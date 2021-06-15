//
//  RacesViewModel.swift
//  42Events
//
//  Created by Phuc Nguyen on 12/06/2021.
//

import Foundation
import RxSwift
import RxCocoa

enum RacesViewModel: ViewModelType {
    struct Inputs {
        let close: Observable<Void>
        let medalViewToggle: Observable<Bool>
    }
    
    struct Outputs {
        let sections: Observable<[RacesSection]>
        let medalViewChanged: Observable<Bool>
    }
    
    enum Action {
        case close
    }
    
    static func viewModel(category: Category) -> (Inputs) -> (Outputs, Driver<Action>) {
        return { inputs in
            
            let response = Observable.just(())
                .flatMapLatest({ () -> Observable<Result<Data>> in
                    let request: Requests
                    switch category {
                    case .running:
                        request = Requests.runningEvents(skip: 0, limit: 10)
                    case .cycling:
                        request = Requests.cyclingEvents(skip: 0, limit: 10)
                    case .walking:
                        request = Requests.walkingEvents(skip: 0, limit: 10)
                    }
                    
                    return URLSession.shared.rx.dataTask(with: request.urlRequest)
                })
                .share(replay: 1)
            
            let races = response
                .compactMap { $0.success }
                .map({ data -> [Race] in
                    let races = try JSONDecoder().decode(ServerResponse<[Race]>.self, from: data).data
                    return races
                })
            
            let medalViewChanged = inputs.medalViewToggle.startWith(false)
                .share(replay: 1)
            
            let sections = Observable.combineLatest(races, medalViewChanged) { races, isMedal -> [RacesSection] in
                let dateFormatter = ISO8601DateFormatter()
                dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                return [
                    .races(title: "\(races.count) \(category.rawValue) events", items: races.map {
                        let viewModel = EventCellViewModel(race: $0, startDate: dateFormatter.date(from: $0.startDate) ?? Date(), endDate: dateFormatter.date(from: $0.endDate) ?? Date())
                        return isMedal ? .medalRace(viewModel: viewModel) : .race(viewModel: viewModel)
                    })
                ]
            }
            
            let close = inputs.close
                .asDriver(onErrorJustReturn: ())
                .map { Action.close }
            
            return (
                Outputs(
                    sections: sections,
                    medalViewChanged: medalViewChanged
                ),
                Driver.merge(close)
            )
        }
    }
}
