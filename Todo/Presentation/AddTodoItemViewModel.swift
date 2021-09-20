//
//  AddTodoViewModel.swift
//  Todo
//
//  Created by Drew Barnes on 19/09/2021.
//

import Foundation

struct AddoTodoItemLabelRequiredError: Error & Exception {
    var message: String {
        "Todo field is required"
    }
}

struct AddoTodoItemDueDateRequiredError: Error & Exception {
    var message: String {
        "Due Date field is required"
    }
}

struct AddoTodoItemDueDateInvalidError: Error & Exception {
    var message: String {
        "Due Date must not be in the past"
    }
}

final class AddTodoItemViewModel {
    private var repository: TodoItemCreateRepository!

    @Published private(set) var onAddItem: TodoItem?
    @Published private(set) var onError: Error?

    init(repository: TodoItemCreateRepository) {
        self.repository = repository
    }

    func addTodo(label: String?, dueDate: Date?, notes: String? = nil) {

        do {
            let aLabel = try validate(label: label)
            let aDueDate = try validate(dueDate: dueDate)
            let futureDueDate = try ensureDueDateIsInTheFuture(dueDate: aDueDate)

            repository.add(label: aLabel, dueDate: futureDueDate, notes: notes) { [weak self] result in
                switch result {
                case .success(let item):
                    self?.onAddItem = item
                case .failure(let error):
                    self?.onError = error
                }
            }
        } catch let error {
            self.onError = error
        }
    }

    private func validate(label: String?) throws -> String {
        guard let label = label else {
            throw AddoTodoItemLabelRequiredError()
        }
        return label
    }

    private func validate(dueDate: Date?) throws -> Date {
        guard let dueDate = dueDate else {
            throw AddoTodoItemDueDateRequiredError()
        }
        return dueDate
    }

    private func ensureDueDateIsInTheFuture(dueDate: Date) throws -> Date {
        let today = Date()

        guard dueDate >= today else {
            throw AddoTodoItemDueDateInvalidError()
        }

        return dueDate
    }
}
