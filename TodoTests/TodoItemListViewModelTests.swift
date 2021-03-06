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

    func test_name_returns_listName() {
        let sut = makeSUT(items: todos)

        XCTAssertEqual(sut.name, "default list")
    }

    func test_viewItemAtIndex_returns_item() {
        let sut = makeSUT(items: todos)
        sut.fetchTodos()

        XCTAssertEqual(sut.item(at: 0).todoItem, todos[0])
    }

    func test_viewItem_with_invalidIndex_returns_nil() {
        let sut = makeSUT()
        sut.fetchTodos()

        XCTAssertEqual(sut.item(at: -1), TodoItemViewModel())
        XCTAssertEqual(sut.item(at: 5), TodoItemViewModel())
    }

    func test_count() {
        let sut = makeSUT(items: todos)
        sut.fetchTodos()

        XCTAssertEqual(sut.count, todos.count)
    }

    func test_deleteTodo_removes_item_from_repository_and_updates_list() {
        let item = todos[0]
        let sut = makeSUT(items: [item])
        sut.fetchTodos()

        XCTAssertEqual(sut.count, 1)

        sut.deleteTodo(item.id)

        XCTAssertEqual(sut.count, 0)
    }

    // MARK: Helpers

    func makeSUT(items: [TodoItem] = []) -> TodoItemListViewModel {
        let list = TodoItemList(name: "default list")
        let repository = TodoItemRepositoryStub()
        repository.todos = items

        return TodoItemListViewModel(list: list, repository: repository)
    }

    final class TodoItemRepositoryStub: TodoItemReadUpdateDestroyRepository {

        var todos = [TodoItem]()

        func load(completion: @escaping (Result<[TodoItem], Error>) -> Void) {
            completion(.success(todos))
        }

        func update(id: TodoItem.ID, data: TodoItem) {
        }

        func remove(id: TodoItem.ID, completion: @escaping (Result<TodoItem, Error>) -> Void) {
            if let found = todos.firstIndex(where: { $0.id == id }) {
                let item = todos[found]
                todos.remove(at: found)
                completion(.success(item))
            } else {
                let error = RepositoryError.recordNotFound
                completion(.failure(error))
            }
        }
    }
}
