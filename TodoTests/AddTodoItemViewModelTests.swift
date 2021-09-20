//
//  AddTodoViewModel.swift
//  TodoTests
//
//  Created by Drew Barnes on 19/09/2021.
//

import XCTest
@testable import Todo

class AddTodoItemViewModelTests: XCTestCase {

    func test_addTodo_createsAndReturnsTodoItem() {
        let sut = makeSut().sut

        XCTAssertNil(sut.onAddItem)
        sut.addTodo(label: "todo #1", dueDate: Date(), notes: "a good note")

        XCTAssertNotNil(sut.onAddItem)
    }

    // MARK: Helpers
    func makeSut() -> (sut: AddTodoItemViewModel, repo: TodoItemRepositoryStub) {
        let repo = TodoItemRepositoryStub()
        let vm = AddTodoItemViewModel(repository: repo)
        return (vm, repo)
    }

    final class TodoItemRepositoryStub: TodoItemCreateRepository {
        func add(
            label: String,
            dueDate: Date,
            notes: String?,
            completion: @escaping (Result<TodoItem, Error>) -> Void
        ) {
            let item = TodoItem(
                label: label,
                dueDate: dueDate,
                notes: notes
            )
            completion(.success(item))
        }
    }
}
