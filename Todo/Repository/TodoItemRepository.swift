//
//  TodoItemRepository.swift
//  Todo
//
//  Created by Drew Barnes on 13/09/2021.
//

import Foundation

enum RepositoryError: Error {
    case recordNotFound
}

protocol TodoItemReadRepository {
    func load(completion: @escaping (Result<[TodoItem], Error>) -> Void)
}

protocol TodoItemCreateRepository {
    func add(label: String, dueDate: Date, notes: String?, completion: @escaping (Result<TodoItem, Error>) -> Void)
}

protocol TodoItemUpdateRepository {
    func update(id: TodoItem.ID, data: TodoItem)
}

protocol TodoItemRemoveRepository {
    func remove(id: TodoItem.ID, completion: @escaping (Result<TodoItem, Error>) -> Void)
}

typealias TodoItemRepository = TodoItemReadRepository &
    TodoItemCreateRepository &
    TodoItemUpdateRepository &
    TodoItemRemoveRepository

typealias TodoItemReadUpdateDestroyRepository = TodoItemReadRepository &
    TodoItemUpdateRepository &
    TodoItemRemoveRepository
