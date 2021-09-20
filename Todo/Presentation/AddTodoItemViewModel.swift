//
//  AddTodoViewModel.swift
//  Todo
//
//  Created by Drew Barnes on 19/09/2021.
//

import Foundation

final class AddTodoItemViewModel {
    private var repository: TodoItemCreateRepository!

    @Published private(set) var onAddItem: TodoItem?
    @Published private(set) var onError: Error?

    init(repository: TodoItemCreateRepository) {
        self.repository = repository
    }

    func addTodo(label: String, dueDate: Date, notes: String? = nil) {
        repository.add(label: label, dueDate: dueDate, notes: notes) { [weak self] result in
            switch result {
            case .success(let item):
                self?.onAddItem = item
            case .failure(let error):
                self?.onError = error
            }
        }
    }
}
