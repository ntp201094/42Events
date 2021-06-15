//
//  Response.swift
//  42Events
//
//  Created by Phuc Nguyen on 29/05/2021.
//

import Foundation

struct ServerResponse<Data>: Decodable where Data: Decodable {
    let code: Int
    let data: Data
}
