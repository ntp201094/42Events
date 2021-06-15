//
//  Category.swift
//  42Events
//
//  Created by Phuc Nguyen on 05/06/2021.
//

import UIKit

enum Category: String, CaseIterable {
    case running
    case cycling
    case walking
    
    var displayName: String {
        switch self {
        case .running:
            return "Running"
        case .cycling:
            return "Cycling"
        case .walking:
            return "Walking"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .running:
            return UIImage(named: "category-run")
        case .cycling:
            return UIImage(named: "category-bike")
        case .walking:
            return UIImage(named: "category-walk")
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .running:
            return UIColor(named: "category-running")
        case .cycling:
            return UIColor(named: "category-cycling")
        case .walking:
            return UIColor(named: "category-walking")
        }
    }
}
