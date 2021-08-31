//
//  TodoItemTests.swift
//  TodoTests
//
//  Created by Drew Barnes on 31/08/2021.
//

import Foundation
import XCTest
@testable import Todo

class TodoItemTests: XCTestCase {

    func test_TodoItem_is_due() {
        let currentDate = Date()
        let sut = TodoItem(label: "a good task", dueDate: currentDate)
        XCTAssertTrue(sut.isDue)
    }
    
    func test_TodoItem_is_not_due() {
        let sut = TodoItem(label: "a good task", dueDate: .distantFuture)
        XCTAssertFalse(sut.isDue)
    }

}
