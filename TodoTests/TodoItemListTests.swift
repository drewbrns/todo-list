//
//  TodoItemTests.swift
//  TodoTests
//
//  Created by Drew Barnes on 31/08/2021.
//

import Foundation
import XCTest
@testable import Todo

class TodoItemListTests: XCTestCase {

    func test_initialState_of_list() {
        let sut = makeSut()

        XCTAssertEqual(sut.name,  "Default List")
        XCTAssertEqual(sut.count, 0)
        XCTAssertTrue(sut.isEmpty)
    }

    func test_addItem_to_list() {
        let sut = makeSut()
        sut.addItem("A new entry")

        XCTAssertEqual(sut.count, 1)
    }

    func test_itemForRow() {
        let sut = makeSut()
        let row = 0
        let item = "A new item"

        sut.addItem(item)

        XCTAssertEqual(sut.item(at: row), item)
    }

    func test_moveItem_to_index_0() {
        let sut = makeSut()
        sut.addItem("Todo1")
        sut.addItem("Todo2")

        try? sut.move(item: "Todo2" , to: 0)

        XCTAssertEqual(sut.item(at: 0), "Todo2")
        XCTAssertEqual(sut.item(at: 1), "Todo1")
    }

    func test_moveItem_to_position_TodoItem_infront_of_other_items() {
        let sut = makeSut()
        sut.addItem("Todo1")
        sut.addItem("Todo2")
        sut.addItem("Todo3")
        sut.addItem("Todo4")

        try? sut.move(item: "Todo4" , to: 1)

        XCTAssertEqual(sut.item(at: 0), "Todo1")
        XCTAssertEqual(sut.item(at: 1), "Todo4")
        XCTAssertEqual(sut.item(at: 2), "Todo2")
        XCTAssertEqual(sut.item(at: 3), "Todo3")
    }

    func test_moveItem_to_position_TodoItem_behind_other_items() {
        let sut = makeSut()
        sut.addItem("Todo1")
        sut.addItem("Todo2")
        sut.addItem("Todo3")
        sut.addItem("Todo4")

        try? sut.move(item: "Todo1" , to: 3)

        XCTAssertEqual(sut.item(at: 0), "Todo2")
        XCTAssertEqual(sut.item(at: 1), "Todo3")
        XCTAssertEqual(sut.item(at: 2), "Todo4")
        XCTAssertEqual(sut.item(at: 3), "Todo1")
    }

    func test_moveItem_throws_error_if_item_is_not_in_list() {
        var thrownError: Error?
        let sut = makeSut()
        sut.addItem("Todo2")

        XCTAssertThrowsError(try sut.move(item: "Todo1", to: 0)) { error  in
            thrownError = error
        }

        XCTAssertTrue(thrownError is TodoItemList.ListError)
    }

    func test_removeItem_throws_error_when_item_is_not_in_list() {
        var thrownError: Error?
        let sut = makeSut()

        XCTAssertThrowsError(try sut.remove(item: "Todo1")) { error  in
            thrownError = error
        }

        XCTAssertTrue(thrownError is TodoItemList.ListError)
    }
    
    func test_removeItem_from_list() {
        let sut = makeSut()
        sut.addItem("Todo1")

        try? sut.remove(item: "Todo1")
        XCTAssertTrue(sut.isEmpty)
    }

    // MARK: Helpers
    
    func makeSut() -> TodoItemList {
        let sut = TodoItemList(name: "Default List")
        return sut
    }

}
