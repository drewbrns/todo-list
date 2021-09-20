//
//  Test+Helpers.swift
//  TodoTests
//
//  Created by Drew Barnes on 20/09/2021.
//

import Foundation

final class TimeTraveler {
    private var date = Date()

    func travel(by timeInterval: TimeInterval) {
        date = date.addingTimeInterval(timeInterval)
    }

    func generateDate() -> Date {
        return date
    }
}
