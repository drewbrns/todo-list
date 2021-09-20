//
//  AddTodoViewControllerTests.swift
//  TodoTests
//
//  Created by Drew Barnes on 18/09/2021.
//

import XCTest
@testable import Todo

class AddTodoViewControllerTests: XCTestCase {

    func test_init() {
        XCTAssertNotNil(makeSut().todoItemLabelTextField)
        XCTAssertNotNil(makeSut().todoItemNotesTextView)
        XCTAssertNotNil(makeSut().todoItemDueDatePicker)
        XCTAssertNotNil(makeSut().submitButton)
        XCTAssertNotNil(makeSut().vm)
    }

    func test_viewDidLoad_renderTitle() {
        let sut = makeSut(title: "Add Todo")
        XCTAssertEqual(sut.title, "Add Todo")
    }

    // MARK: Helpers

    func makeSut(title: String = "") -> AddTodoViewController {
        let repository = TodoItemCreateRepositoryStub()
        let vm = AddTodoItemViewModel(repository: repository)
        let sut = AddTodoViewController(title: title, viewModel: vm)
        sut.loadViewIfNeeded()
        return sut
    }

    final class TodoItemCreateRepositoryStub: TodoItemCreateRepository {
        func add(
            label: String,
            dueDate: Date,
            notes: String?,
            completion: @escaping (Result<TodoItem, Error>) -> Void) {
            let item = TodoItem(
                label: "todo #1",
                dueDate: .distantPast,
                notes: "a good day!"
            )

            completion(.success(item))
        }
    }

}
