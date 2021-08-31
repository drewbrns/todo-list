//
//  ItemList.swift
//  Todo
//
//  Created by Drew Barnes on 31/08/2021.
//

import Foundation

enum ItemListError: Error {
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

final class TodoItemList {

    private(set) var name: String
    private var items = [String]()

    var count: Int {
        return items.count
    }

    var isEmpty: Bool {
        return items.isEmpty
    }

    init(name: String) {
        self.name = name
    }

    func addItem(_ item: String) {
        self.items.append(item)
    }

    func item(at index: Int) -> String {
        return items[index]
    }

    func move(item: String, to index: Int) throws {
        guard let currentIndex = items.firstIndex(of: item) else {
            throw ItemListError.moveError(index)
        }

        items.remove(at: currentIndex)
        items.insert(item, at: index)
    }

    func remove(item: String) throws {
        guard let currentIndex = items.firstIndex(of: item) else {
            throw ItemListError.removeError
        }
        items.remove(at: currentIndex)
    }

}
