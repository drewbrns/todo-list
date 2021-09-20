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
        let traveller = TimeTraveler()
        traveller.travel(by: 60 * 60)

        XCTAssertNil(sut.onAddItem)
        sut.addTodo(label: "todo #1", dueDate: traveller.generateDate(), notes: "a good note")
        XCTAssertNotNil(sut.onAddItem)
    }

    func test_addTodo_withInvalidTodoLabelInput_errors() {
        let sut = makeSut().sut
        XCTAssertNil(sut.onError)

        sut.addTodo(label: nil, dueDate: Date(), notes: "a good note")

        XCTAssertNotNil(sut.onError)
        XCTAssertTrue(sut.onError is AddoTodoItemLabelRequiredError)
    }

    func test_addTodo_withInvalidDueDateInput_errors() {
        let sut = makeSut().sut
        XCTAssertNil(sut.onError)

        sut.addTodo(label: "todo #1", dueDate: nil, notes: "a good note")

        XCTAssertNotNil(sut.onError)
        XCTAssertTrue(sut.onError is AddoTodoItemDueDateRequiredError)
    }

    func test_addTodo_errorsWhenDueDateIsInThePast() {
        let sut = makeSut().sut
        XCTAssertNil(sut.onError)

        sut.addTodo(label: "todo #1", dueDate: .distantPast, notes: "a good note")

        XCTAssertNotNil(sut.onError)
        XCTAssertTrue(sut.onError is AddoTodoItemDueDateInvalidError)
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

    final class TimeTraveler {
        private var date = Date()

        func travel(by timeInterval: TimeInterval) {
            date = date.addingTimeInterval(timeInterval)
        }

        func generateDate() -> Date {
            return date
        }
    }
}
