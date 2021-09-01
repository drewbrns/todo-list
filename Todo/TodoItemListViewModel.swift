//
//  TodoItemListViewModel.swift
//  Todo
//
//  Created by Drew Barnes on 01/09/2021.
//

import Foundation
import Combine

protocol TodoItemStore {
    associatedtype StoredObject

    func loadObjects(completion: @escaping (Result<[StoredObject], Error>) -> Void)
}

final class TodoItemListViewModel<Store: TodoItemStore>: ObservableObject {

    private var list: ItemList
    private var store: Store
    
    @Published var onComplete: Bool = false
    @Published var onError: Error?

    init(list: ItemList, store: Store) {
        self.list = list
        self.store = store

        self.fetchData()
    }

    var count: Int {
        return list.count
    }
    
    func item(at index: Int) -> TodoItem? {
        guard index >= 0 && index <= list.count else { return nil }
        return list.item(at: index)
    }

    func fetchData() {
        self.store.loadObjects { [weak self] result in
            switch result {
            case .success(let objects):
                objects.forEach {
                    if let _item = $0 as? TodoItem {
                        try? self?.list.add(item: _item)
                    }
                }
                self?.onComplete = true
            case .failure(let error):
                self?.onError = error
            }
        }
    }

}
