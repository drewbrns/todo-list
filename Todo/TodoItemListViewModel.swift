//
//  TodoItemListViewModel.swift
//  Todo
//
//  Created by Drew Barnes on 01/09/2021.
//

import Foundation
import Combine

protocol TodoItemRepository {
    func loadObjects(completion: @escaping (Result<[TodoItem], Error>) -> Void)
    func addObject(_ label: String, dueDate: Date, notes: String?) -> TodoItem
}

final class TodoItemListViewModel: ObservableObject {

    private var list: ItemList
    private var repository: TodoItemRepository

    @Published var onComplete: Bool = false
    @Published var onError: Error?

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

    func fetchData() {
        self.repository.loadObjects { [weak self] result in
            switch result {
            case .success(let objects):
                objects.forEach {
                    try? self?.list.add(item: $0)
                }
                self?.onComplete = true
            case .failure(let error):
                self?.onError = error
            }
        }
    }

    func addTodo(label: String, dueDate: Date, notes: String?) {
        let todoItem = self.repository.addObject(
            label,
            dueDate: dueDate,
            notes: notes
        )

        try? self.list.add(item: todoItem)
    }

    func deleteTodo() {
    }

}
