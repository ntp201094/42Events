//
//  Dashboard.swift
//  42Events
//
//  Created by Phuc Nguyen on 29/05/2021.
//

import Foundation

struct Dashboard: Decodable {
    let featured, startingSoon, popular, newRelease, free, past: [Race]
}
