//
//  Test+Helpers.swift
//  TodoTests
//
//  Created by Drew Barnes on 19/09/2021.
//

import XCTest
@testable import Todo

final class TodoItemRepositoryStub: TodoItemRepository {

    var todos = [TodoItem]()

    func load(completion: @escaping (Result<[TodoItem], Error>) -> Void) {
        completion(.success(todos))
    }

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

        todos.append(item)

        completion(.success(item))
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
