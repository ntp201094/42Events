//
//  RxSwift+Operators.swift
//  42Events
//
//  Created by Phuc Nguyen on 29/05/2021.
//

import RxSwift

extension Observable {
    func asVoid() -> Observable<Void> {
        self.map { _ in }
    }
}
