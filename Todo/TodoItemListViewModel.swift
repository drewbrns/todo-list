//
//  TodoItemListViewModel.swift
//  Todo
//
//  Created by Drew Barnes on 01/09/2021.
//

import Foundation
import Combine

final class TodoItemListViewModel: ObservableObject {

    private var list: ItemList
    private var repository: TodoItemRepository

    @Published private(set) var onFetchComplete: Bool = false
    @Published private(set) var onAddComplete: Bool = false
    @Published private(set) var onRemoveComplete: Bool = false
    @Published private(set) var onError: Error?

    init(list: ItemList, repository: TodoItemRepository) {
        self.list = list
        self.repository = repository
    }

    var count: Int {
        return list.count
    }
    
    func item(at index: Int) -> TodoItem? {
        guard index >= 0 && index <= list.count else { return nil }
        return list.item(at: index)
    }

    func fetchTodos() {
        self.repository.load { [weak self] result in
            switch result {
            case .success(let objects):
                objects.forEach {
                    try? self?.list.add(item: $0)
                }
                self?.onFetchComplete = true
            case .failure(let error):
                self?.onError = error
            }
        }
    }

    func addTodo(label: String, dueDate: Date, notes: String?) {
        self.repository.add(
            label: label,
            dueDate: dueDate,
            notes: notes
        ) { [weak self] result in
            switch result {
            case .success(let todoItem):
                do {
                    try self?.list.add(item: todoItem)
                    self?.onAddComplete = true
                } catch let error {
                    self?.onError = error
                }
            case .failure(let error):
                self?.onError = error
            }
        }
    }

    func deleteTodo(_ itemId: TodoItem.ID) {
        self.repository.remove(id: itemId) { [weak self] result in
            switch result {
            case .success(let item):
                do {
                    try self?.list.remove(item: item)
                    self?.onRemoveComplete = true
                } catch let error {
                    self?.onError = error
                }
            case .failure(let error):
                self?.onError = error
            }
        }
    }

}
