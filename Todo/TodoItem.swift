//
//  TodoItem.swift
//  Todo
//
//  Created by Drew Barnes on 31/08/2021.
//

import Foundation

struct TodoItem {
    var label: String
    var dueDate: Date = .distantFuture
    var isComplete: Bool = false
    var notes: String?

    var isDue: Bool {
        return dueDate < Date()
    }
}

extension TodoItem: Equatable {
    static func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
        return lhs.label == rhs.label &&
            lhs.dueDate == rhs.dueDate &&
            lhs.isComplete == rhs.isComplete &&
            lhs.notes == rhs.notes
    }
}
