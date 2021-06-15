//
//  UIKit+Helpers.swift
//  42Events
//
//  Created by Phuc Nguyen on 29/05/2021.
//

import UIKit

extension UIViewController {
    static func top() -> UIViewController {
        guard let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else { fatalError("No view controller present in app?") }
        var result = rootViewController
        while let vc = result.presentedViewController {
            result = vc
        }

        if let navigation = result as? UINavigationController {
            result = navigation.topViewController ?? navigation
        }
        return result
    }
}
