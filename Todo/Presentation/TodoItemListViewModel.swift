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
    private var repository: TodoItemReadUpdateDestroyRepository

    @Published private(set) var onFetchComplete: Bool = false
    @Published private(set) var onRemoveComplete: Bool = false
    @Published private(set) var onError: Error?

    var name: String {
        return self.list.name
    }

    init(list: ItemList, repository: TodoItemReadUpdateDestroyRepository) {
        self.list = list
        self.repository = repository
    }

    var count: Int {
        return list.count
    }

    func item(at index: Int) -> TodoItemViewModel {
        guard index >= 0 && index <= list.count else { return TodoItemViewModel() }
        let todoItem = list.item(at: index)
        return TodoItemViewModel(todoItem: todoItem)
    }

    func fetchTodos() {
        self.repository.load { [weak self] result in
            switch result {
            case .success(let objects):
                self?.add(items: objects)
                self?.onFetchComplete = true
            case .failure(let error):
                self?.publish(error: error)
            }
        }
    }

    func deleteTodo(_ itemId: TodoItem.ID) {
        self.repository.remove(id: itemId) { [weak self] result in
            switch result {
            case .success(let item):
                self?.remove(item: item)
                self?.onRemoveComplete = true
            case .failure(let error):
                self?.publish(error: error)
            }
        }
    }

    private func add(items: [TodoItem]) {
        items.forEach {
            do {
                try self.list.add(item: $0)
            } catch let error {
                self.publish(error: error)
            }
        }
    }

    private func remove(item: TodoItem) {
        do {
            try self.list.remove(item: item)
        } catch let error {
            self.publish(error: error)
        }
    }

    private func publish(error: Error) {
        self.onError = error
    }

}
