//
//  TodoItemListViewModelTests.swift
//  TodoTests
//
//  Created by Drew Barnes on 01/09/2021.
//

import Foundation
import XCTest
@testable import Todo

class TodoItemListViewModelTests: XCTestCase {

    let todos = [
        TodoItem(label: "Todo1"),
        TodoItem(label: "Todo2"),
        TodoItem(label: "Todo3"),
        TodoItem(label: "Todo4")
    ]

    func test_viewItemAtIndex() {
        XCTAssertEqual(makeSUT().item(at: 0), todos[0])
    }

    func test_viewItemAtInvalidIndex() {
        XCTAssertNil(makeSUT().item(at: -1))
        XCTAssertNil(makeSUT().item(at: 5))
    }

    func test_count() {
        XCTAssertEqual(makeSUT().count, todos.count)
    }


    // MARK: Helpers

    final class TodoItemStoreStub: TodoItemStore {
        typealias StoredObject = TodoItem
        let stub = (query: "a query", todos:
            [
                TodoItem(label: "Todo1"),
                TodoItem(label: "Todo2"),
                TodoItem(label: "Todo3"),
                TodoItem(label: "Todo4")
            ]
        )

        func loadObjects(completion: @escaping (Result<[TodoItem], Error>) -> Void) {
            completion(.success(stub.todos))
        }
    }

    func makeSUT() -> TodoItemListViewModel<TodoItemStoreStub> {
        let list = TodoItemList(name: "default list")
        let store = TodoItemStoreStub()
        return TodoItemListViewModel(list: list, store: store)
    }

}
