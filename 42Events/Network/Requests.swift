//
//  Requests.swift
//  42Events
//
//  Created by Phuc Nguyen on 29/05/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: URLSession {
    func dataTask(with request: URLRequest) -> Observable<Result<Data>> {
        return URLSession.shared.rx.data(request: request)
            .materialize()
            .filter { $0.isCompleted == false }
            .map { $0.asResult }
    }
}

extension Event {
    var asResult: Result<Element> {
        switch self {
        case .next(let element):
            return .success(element)
        case .error(let error):
            return .error(error)
        case .completed:
            fatalError("This case never happen.")
        }
    }
}

enum Requests {
    case dashboard
    case runningEvents(skip: Int, limit: Int)
    case cyclingEvents(skip: Int, limit: Int)
    case walkingEvents(skip: Int, limit: Int)
    
    var baseURLString: String { return Configuration.baseURLString }
    
    var path: String {
        var path = "/api/v1"
        switch self {
        case .dashboard:
            path += "/race-events"
        case .runningEvents, .cyclingEvents, .walkingEvents:
            path += "/race-filters"
        }
        
        return path
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .dashboard:
            return []
        case let .runningEvents(skip, limit):
            return [
                URLQueryItem(name: "skipCount", value: "\(skip)"),
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "sportType", value: "running")
            ]
        case let .cyclingEvents(skip, limit):
            return [
                URLQueryItem(name: "skipCount", value: "\(skip)"),
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "sportType", value: "cycling")
            ]
        case let .walkingEvents(skip, limit):
            return [
                URLQueryItem(name: "skipCount", value: "\(skip)"),
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "sportType", value: "walking")
            ]
        }
    }
    
    var urlRequest: URLRequest {
        var components = URLComponents(string: baseURLString)!
        components.path = self.path
        components.queryItems = self.queryItems
        var request = URLRequest(url: components.url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
