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
    }

    func test_viewDidLoad_renderTitle() {
        let sut = makeSut(title: "Add TodoItem")
        XCTAssertEqual(sut.title, "Add TodoItem")
    }

    // MARK: Helpers

    func makeSut(title: String = "") -> AddTodoViewController {
        let sut = AddTodoViewController(title: title)
        sut.loadViewIfNeeded()
        return sut
    }

}
