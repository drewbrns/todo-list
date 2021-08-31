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
        let todo1 = TodoItem(label: "A new entry")
        try? sut.add(item: todo1)

        XCTAssertEqual(sut.count, 1)
    }

    func test_addItem_throws_error_when_item_already_exists() {
        var thrownError: Error?
        let sut = makeSut()
        try? sut.add(item: TodoItem(label: "todo1"))

        XCTAssertThrowsError(try sut.add(item: TodoItem(label: "todo1"))) { error  in
            thrownError = error
        }

        XCTAssertTrue(thrownError is TodoItemList.ListError)
    }

    func test_itemForRow() {
        let sut = makeSut()
        let row = 0
        let item = TodoItem(label: "A new item")

        try? sut.add(item: item)

        XCTAssertEqual(sut.item(at: row), item)
    }

    func test_moveItem_to_index_0() {
        let sut = makeSut()
        let todo1 = TodoItem(label: "Todo1")
        let todo2 = TodoItem(label: "Todo2")
        
        try? sut.add(item: todo1)
        try? sut.add(item: todo2)

        try? sut.move(item: todo2 , to: 0)

        XCTAssertEqual(sut.item(at: 0), todo2)
        XCTAssertEqual(sut.item(at: 1), todo1)
    }

    func test_moveItem_to_position_TodoItem_infront_of_other_items() {
        let sut = makeSut()
        let todo1 = TodoItem(label: "Todo1")
        let todo2 = TodoItem(label: "Todo2")
        let todo3 = TodoItem(label: "Todo3")
        let todo4 = TodoItem(label: "Todo4")
        try? sut.add(item: todo1)
        try? sut.add(item: todo2)
        try? sut.add(item: todo3)
        try? sut.add(item: todo4)

        try? sut.move(item: todo4 , to: 1)

        XCTAssertEqual(sut.item(at: 0), todo1)
        XCTAssertEqual(sut.item(at: 1), todo4)
        XCTAssertEqual(sut.item(at: 2), todo2)
        XCTAssertEqual(sut.item(at: 3), todo3)
    }

    func test_moveItem_to_position_TodoItem_behind_other_items() {
        let sut = makeSut()
        let todo1 = TodoItem(label: "Todo1")
        let todo2 = TodoItem(label: "Todo2")
        let todo3 = TodoItem(label: "Todo3")
        let todo4 = TodoItem(label: "Todo4")
        try? sut.add(item: todo1)
        try? sut.add(item: todo2)
        try? sut.add(item: todo3)
        try? sut.add(item: todo4)

        try? sut.move(item: todo1 , to: 3)

        XCTAssertEqual(sut.item(at: 0), todo2)
        XCTAssertEqual(sut.item(at: 1), todo3)
        XCTAssertEqual(sut.item(at: 2), todo4)
        XCTAssertEqual(sut.item(at: 3), todo1)
    }

    func test_moveItem_throws_error_if_item_is_not_in_list() {
        var thrownError: Error?
        let sut = makeSut()
        try? sut.add(item: TodoItem(label: "Todo2"))

        XCTAssertThrowsError(try sut.move(item: TodoItem(label: "todo1"), to: 0)) { error  in
            thrownError = error
        }

        XCTAssertTrue(thrownError is TodoItemList.ListError)
    }

    func test_removeItem_throws_error_when_item_is_not_in_list() {
        var thrownError: Error?
        let sut = makeSut()

        XCTAssertThrowsError(try sut.remove(item: TodoItem(label: "todo1"))) { error  in
            thrownError = error
        }

        XCTAssertTrue(thrownError is TodoItemList.ListError)
    }

    func test_removeItem_from_list() {
        let sut = makeSut()
        let todo1 = TodoItem(label: "Todo1")
        try? sut.add(item: todo1)

        try? sut.remove(item: todo1)
        XCTAssertTrue(sut.isEmpty)
    }
    
    // MARK: Helpers
    
    func makeSut() -> TodoItemList {
        let sut = TodoItemList(name: "Default List")
        return sut
    }

}
