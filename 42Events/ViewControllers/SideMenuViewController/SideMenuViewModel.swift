//
//  SideMenuViewModel.swift
//  42Events
//
//  Created by Phuc Nguyen on 10/06/2021.
//

import Foundation
import RxSwift
import RxCocoa

enum SideMenuViewModel: ViewModelType {
    struct Inputs {
        let changeMode: Observable<Bool>
    }
    
    struct Outputs {
        let sections: Observable<[SideMenuSection]>
        let modeChanged: Observable<Bool>
    }
    
    enum Action {
        
    }
    
    static func viewModel() -> (Inputs) -> (Outputs, Driver<Action>) {
        return { inputs in
            
            let sections = Observable.just(MenuItem.allCases)
                .map { items in
                    [
                        SideMenuSection.menu(items: items.map {
                            switch $0 {
                            case .logIn, .signUp, .guidesFAQ, .contactUs, .language:
                                return SideMenuSectionItem.text(viewModel: MenuItemViewModel(item: $0))
                            case .modeSwitcher:
                                return SideMenuSectionItem.switcher(viewModel: MenuItemViewModel(item: $0))
                            }
                        })
                    ]
                }
            
            let modeChanged = inputs.changeMode
                .startWith(UIApplication.shared.windows.first!.overrideUserInterfaceStyle == .dark ? true : false)
                .observe(on: MainScheduler.instance)
                .do(onNext: {
                    UserDefaults.standard.set($0, forKey: "UIStyle")
                    UIApplication.shared.windows.first!.overrideUserInterfaceStyle = $0 ? .dark : .light
                })
            
            return (
                Outputs(
                    sections: sections,
                    modeChanged: modeChanged
                ),
                Driver.merge()
            )
        }
    }
}
