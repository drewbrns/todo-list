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

protocol TodoItemRepository {
    func load(completion: @escaping (Result<[TodoItem], Error>) -> Void)
    func add(label: String, dueDate: Date, notes: String?, completion: @escaping (Result<TodoItem, Error>) -> Void)
    func remove(id: TodoItem.ID, completion: @escaping (Result<TodoItem, Error>) -> Void)
}
