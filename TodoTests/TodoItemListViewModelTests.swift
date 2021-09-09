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

    func test_viewItemAtIndex_returns_item() {
        let sut = makeSUT()
        sut.fetchData()

        XCTAssertEqual(sut.item(at: 0), todos[0])
    }

    func test_viewItem_with_invalidIndex_returns_nil() {
        let sut = makeSUT()
        sut.fetchData()

        XCTAssertNil(sut.item(at: -1))
        XCTAssertNil(sut.item(at: 5))
    }

    func test_count() {
        let sut = makeSUT()
        sut.fetchData()

        XCTAssertEqual(sut.count, todos.count)
    }

    // MARK: Helpers

    final class TodoItemRepositoryStub: TodoItemRepository {
        typealias StoredObject = TodoItem

        var todos = [TodoItem]()
        
        func loadObjects(completion: @escaping (Result<[TodoItem], Error>) -> Void) {
            completion(.success(todos))
        }
    }

    func makeSUT() -> TodoItemListViewModel<TodoItemRepositoryStub> {
        let list = TodoItemList(name: "default list")
        let repository = TodoItemRepositoryStub()
        repository.todos = todos
        return TodoItemListViewModel(list: list, repository: repository)
    }

}
