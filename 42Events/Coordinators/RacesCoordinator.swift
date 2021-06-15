//
//  RacesCoordinator.swift
//  42Events
//
//  Created by Phuc Nguyen on 12/06/2021.
//

import UIKit

func openRaces(category: Category) {
    let racesController = RacesController()
    _ = racesController.installViewModel(RacesViewModel.viewModel(category: category))
        .drive(onNext: { action in
            switch action {
            case .close:
                UIViewController.top().dismiss(animated: true, completion: nil)
            }
        })
    let racesNav = UINavigationController(rootViewController: racesController)
    
    UIViewController.top().present(racesNav, animated: true, completion: nil)
}
