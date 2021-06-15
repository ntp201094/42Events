//
//  MainCoordinator.swift
//  42Events
//
//  Created by Phuc Nguyen on 29/05/2021.
//

import UIKit
import SideMenu

func mainCoordinator(window: UIWindow) {
    let homeVC = HomeViewController()
    _ = homeVC.installViewModel(HomeViewModel.viewModel())
        .drive(onNext: { action in
            switch action {
            case .openMenu:
                openSideMenu()
            case .openRaces(let category):
                openRaces(category: category)
            }
        })
    
    let homeNav = UINavigationController(rootViewController: homeVC)
    window.rootViewController = homeNav
    window.makeKeyAndVisible()
}

func openSideMenu() {
    let menuController = SideMenuController()
    _ = menuController.installViewModel(SideMenuViewModel.viewModel())
        .drive(onNext: { action in
            
        })
    
    let menuNav = SideMenuNavigationController(rootViewController: menuController)
    menuNav.leftSide = true
    menuNav.presentationStyle = .menuSlideIn
    menuNav.statusBarEndAlpha = 0
    
    UIViewController.top().present(menuNav, animated: true)
}
