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
    
    let todos = [
        TodoItem(label: "Todo1"),
        TodoItem(label: "Todo2"),
        TodoItem(label: "Todo3"),
        TodoItem(label: "Todo4")
    ]

    func test_initialState_of_list() {
        let sut = makeSut()

        XCTAssertEqual(sut.name,  "Default List")
        XCTAssertEqual(sut.count, 0)
        XCTAssertTrue(sut.isEmpty)
    }

    func test_addItem_to_list() throws {
        let sut = makeSut()
        let todo1 = TodoItem(label: "A new entry")
        try sut.add(item: todo1)

        XCTAssertEqual(sut.count, 1)
    }

    func test_addItem_throws_error_when_item_already_exists() throws {
        var thrownError: Error?
        let sut = makeSut()
        let todo = TodoItem(label: "todo1")
        try sut.add(item: todo)

        XCTAssertThrowsError(try sut.add(item: todo)) { error  in
            thrownError = error
        }

        XCTAssertTrue(thrownError is TodoItemList.DuplicateEntryListError)
    }

    func test_itemForRow() {
        let sut = makeSut(items: [todos[0]])

        XCTAssertEqual(sut.item(at: 0), todos[0])
    }

    func test_moveItem_to_index_0() throws {
        let sut = makeSut(items: [todos[0], todos[1]])

        try sut.move(item: todos[1] , to: 0)

        XCTAssertEqual(sut.item(at: 0), todos[1])
        XCTAssertEqual(sut.item(at: 1), todos[0])
    }

    func test_moveItem_to_position_TodoItem_infront_of_other_items() throws {
        let sut = makeSut(items: todos)
        try sut.move(item: todos[3] , to: 1)

        XCTAssertEqual(sut.item(at: 0), todos[0])
        XCTAssertEqual(sut.item(at: 1), todos[3])
        XCTAssertEqual(sut.item(at: 2), todos[1])
        XCTAssertEqual(sut.item(at: 3), todos[2])
    }

    func test_moveItem_to_position_TodoItem_behind_other_items() throws {
        let sut = makeSut(items: todos)
        try sut.move(item: todos[0] , to: 3)

        XCTAssertEqual(sut.item(at: 0), todos[1])
        XCTAssertEqual(sut.item(at: 1), todos[2])
        XCTAssertEqual(sut.item(at: 2), todos[3])
        XCTAssertEqual(sut.item(at: 3), todos[0])
    }

    func test_moveItem_throws_error_if_item_is_not_in_list() throws {
        var thrownError: Error?
        let sut = makeSut()
        try sut.add(item: TodoItem(label: "Todo2"))

        XCTAssertThrowsError(try sut.move(item: TodoItem(label: "todo1"), to: 0)) { error  in
            thrownError = error
        }

        XCTAssertTrue(thrownError is TodoItemList.MoveItemListError)
    }

    func test_removeItem_throws_error_when_item_is_not_in_list() {
        var thrownError: Error?
        let sut = makeSut()

        XCTAssertThrowsError(try sut.remove(item: TodoItem(label: "todo1"))) { error  in
            thrownError = error
        }

        XCTAssertTrue(thrownError is TodoItemList.RemoveItemListError)
    }

    func test_removeItem_from_list() throws {
        let sut = makeSut(items: [todos[0]])

        try sut.remove(item: todos[0])
        XCTAssertTrue(sut.isEmpty)
    }
    
    // MARK: Helpers
    
    func makeSut(items: [TodoItem] = []) -> TodoItemList {
        let sut = TodoItemList(name: "Default List", items: items)
        return sut
    }

}
