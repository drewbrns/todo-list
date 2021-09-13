//
//  TodoViewControllerTests.swift
//  TodoTests
//
//  Created by Drew Barnes on 13/09/2021.
//

import XCTest
@testable import Todo

class TodoViewControllerTests: XCTestCase {

    func test_init() throws {
        let sut = makeSut()

        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.addButton)
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.vm)
    }

    func test_viewDidLoad_rendersTitle() throws {
        let sut = makeSut()

        XCTAssertEqual(sut.title, "Default List")
    }
    
    // MARK: Helpers
    
    func makeSut() -> TodoViewController {

        let list = TodoItemList(name: "Default List")
        let repository = TodoItemRepositoryStub()

        let viewModel = TodoItemListViewModel(
            list: list,
            repository: repository
        )

        let sut = TodoViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        return sut
    }

    final class TodoItemRepositoryStub: TodoItemRepository {
        var items = [TodoItem]()

        func load(completion: @escaping (Result<[TodoItem], Error>) -> Void) {
        }
        
        func add(label: String, dueDate: Date, notes: String?, completion: @escaping (Result<TodoItem, Error>) -> Void) {
        }
        
        func remove(id: TodoItem.ID, completion: @escaping (Result<TodoItem, Error>) -> Void) {
        }

    }
    
}
