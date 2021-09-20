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

    func test_init_cell() {
        let sut = makeSut(items: [
            TodoItem(label: "todo #1"),
            TodoItem(label: "todo #2")
        ])

        let cell = sut.vc.tableView.cell(at: 0)
        XCTAssertNotNil(cell?.titleLabel)
        XCTAssertNotNil(cell?.subTitleLabel)
        XCTAssertNotNil(cell?.dateLabel)
        XCTAssertNotNil(cell?.checkMarkView)
        XCTAssertNotNil(cell?.checkMarkInnerView)
    }

    func test_viewDidLoad_rendersTodoItems() throws {
        let now = Date()
        let color = UIColor(
            red: 164 / 255,
            green: 31 / 255,
            blue: 36 / 255,
            alpha: 1
        )

        let sut = makeSut(items: [
            TodoItem(label: "todo #1"),
            TodoItem(label: "todo #2", dueDate: now, notes: "todo #2 with notes", isComplete: true)
        ])

        XCTAssertEqual(sut.vc.tableView.title(at: 0), "todo #1")
        XCTAssertEqual(sut.vc.tableView.title(at: 1), "todo #2")
        XCTAssertEqual(sut.vc.tableView.notes(at: 1), "todo #2 with notes")
        XCTAssertEqual(sut.vc.tableView.dueDate(at: 1), now.stringForDisplay(longFormat: "EEEE, MMM d, yyyy"))
        XCTAssertEqual(sut.vc.tableView.isComplete(at: 1), color)
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

    final class TodoItemRepositoryStub: TodoItemReadUpdateDestroyRepository {

        var items = [TodoItem]()

        func load(completion: @escaping (Result<[TodoItem], Error>) -> Void) {
            completion(.success(items))
        }

        func update(id: TodoItem.ID, data: TodoItem) {
        }

        func remove(
            id: TodoItem.ID, completion: @escaping (Result<TodoItem, Error>) -> Void
        ) {
        }
    }

}

private extension UITableView {

    func cell(at row: Int) -> TodoItemCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0)) as? TodoItemCell
    }

    func title(at row: Int) -> String? {
        return cell(at: row)?.titleLabel.text
    }

    func notes(at row: Int) -> String? {
        return cell(at: row)?.subTitleLabel.text
    }

    func dueDate(at row: Int) -> String? {
        return cell(at: row)?.dateLabel.text
    }

    func isComplete(at row: Int) -> UIColor? {
        return cell(at: row)?.checkMarkInnerView.backgroundColor
    }

}
