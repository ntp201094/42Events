//
//  Race.swift
//  42Events
//
//  Created by Phuc Nguyen on 29/05/2021.
//

import Foundation

struct Race: Decodable {
    let name: String
    let imageURL: String
    let medalImageURL: String
    let isFreeEngraving: Bool
    let startDate: String
    let endDate: String
    let sportType: String
    let raceRunners: Int
    let racePrice: String?
    let categories: [String]?
    let eventType: String
    
    enum CodingKeys: String, CodingKey {
        case name = "race_name"
        case imageURL = "banner_card"
        case medalImageURL = "medalViewImage"
        case isFreeEngraving
        case startDate = "start_date"
        case endDate = "end_date"
        case sportType
        case raceRunners
        case racePrice
        case categories
        case eventType
    }
}
