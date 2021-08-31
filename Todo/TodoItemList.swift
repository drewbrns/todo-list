//
//  ItemList.swift
//  Todo
//
//  Created by Drew Barnes on 31/08/2021.
//

import Foundation

final class TodoItemList {

    private(set) var name: String
    private var items = [TodoItem]()

    var count: Int {
        return items.count
    }

    var isEmpty: Bool {
        return items.isEmpty
    }

    init(name: String) {
        self.name = name
    }

    func addItem(_ item: TodoItem) {
        self.items.append(item)
    }

    func item(at index: Int) -> TodoItem {
        return items[index]
    }

    func move(item: TodoItem, to index: Int) throws {
        guard let currentIndex = items.firstIndex(of: item) else {
            throw ListError.moveError(index)
        }

        items.remove(at: currentIndex)
        items.insert(item, at: index)
    }

    func remove(item: TodoItem) throws {
        guard let currentIndex = items.firstIndex(of: item) else {
            throw ListError.removeError
        }
        items.remove(at: currentIndex)
    }

}

extension TodoItemList {

    enum ListError: Error {
        case moveError(Int)
        case removeError

        var reason: String {
            switch self {
            case .moveError(let position):
                return "Cannot move item to this position: \(position)"
            case .removeError:
                return "Cannot remove item from list"
            }
        }
    }

}
