//
//  AddTodoViewModel.swift
//  TodoTests
//
//  Created by Drew Barnes on 19/09/2021.
//

import XCTest
@testable import Todo

class AddTodoViewModelTests: XCTestCase {

    // MARK: Helpers
    func makeSut() -> (sut: AddTodoViewModel, repo: TodoItemRepositoryStub) {
        let repo = TodoItemRepositoryStub()
        let vm = AddTodoViewModel(repository: repo)
        return (vm, repo)
    }
}
