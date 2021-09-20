//
//  AddTodoViewModel.swift
//  Todo
//
//  Created by Drew Barnes on 19/09/2021.
//

import Foundation

final class AddTodoViewModel {
    private var repository: TodoItemRepository!

    @Published private(set) var onAddItem: TodoItem?
    @Published private(set) var onError: Error?

    init(repository: TodoItemRepository) {
        self.repository = repository
    }

    func addItem(label: String, dueDate: Date = .distantFuture, notes: String? = nil) {

        repository.add(label: label, dueDate: dueDate, notes: notes) { [weak self] result in
            switch result {
            case .success(let item):
                self?.onAddItem = item

            case .failure(let error):
                self?.publish(error: error)
            }
        }
    }

    //    func addTodo(label: String, dueDate: Date, notes: String?) {
    //        self.repository.add(
    //            label: label,
    //            dueDate: dueDate,
    //            notes: notes
    //        ) { [weak self] result in
    //            switch result {
    //            case .success(let todoItem):
    //                self?.add(items: [todoItem])
    //                self?.onAddComplete = true
    //            case .failure(let error):
    //                self?.publish(error: error)
    //            }
    //        }
    //    }

    private func publish(error: Error) {
        self.onError = error
    }

}
