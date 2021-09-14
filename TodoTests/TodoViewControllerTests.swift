//
//  TodoViewControllerTests.swift
//  TodoTests
//
//  Created by Drew Barnes on 13/09/2021.
//

import XCTest
@testable import Todo

class TodoViewControllerTests: XCTestCase {

    func test_init() {
        let sut = makeSut().vc

        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.addButton)
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.vm)
    }

    func test_viewDidLoad_rendersTitle() {
        let sut = makeSut().vc

        XCTAssertEqual(sut.title, "Default List")
    }

    func test_viewDidLoad_performs_fetchTodos() {
                
        let sut = makeSut(items: [
            TodoItem(label: "todo #1"),
            TodoItem(label: "todo #2")
        ])

        XCTAssertEqual(sut.vc.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.vc.tableView.numberOfRows(inSection: 0), 2)
    }

    // MARK: Helpers
    
    func makeSut(items: [TodoItem] = []) -> (vc: TodoViewController, repo: TodoItemRepositoryStub) {

        let list = TodoItemList(name: "Default List")
        let repository = TodoItemRepositoryStub()
        repository.items = items

        let viewModel = TodoItemListViewModel(
            list: list,
            repository: repository
        )
        
        let sut = TodoViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        return (sut, repository)
    }

    final class TodoItemRepositoryStub: TodoItemRepository {
        var items = [TodoItem]()

        func load(completion: @escaping (Result<[TodoItem], Error>) -> Void) {
            completion(.success(items))
        }

        func add(label: String, dueDate: Date, notes: String?, completion: @escaping (Result<TodoItem, Error>) -> Void) {
        }

        func remove(id: TodoItem.ID, completion: @escaping (Result<TodoItem, Error>) -> Void) {
        }
    }

}
