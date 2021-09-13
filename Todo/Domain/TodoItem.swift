//
//  TodoItem.swift
//  Todo
//
//  Created by Drew Barnes on 31/08/2021.
//

import Foundation

struct TodoItem: Identifiable {
    var id: UUID = UUID()
    var label: String
    var dueDate: Date = .distantFuture
    var notes: String?
    var isComplete: Bool = false

    var isDue: Bool {
        return dueDate < Date()
    }
}

extension TodoItem: Equatable {
    static func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
        return lhs.id == rhs.id &&
            lhs.label == rhs.label &&
            lhs.dueDate == rhs.dueDate &&
            lhs.isComplete == rhs.isComplete &&
            lhs.notes == rhs.notes
    }
}
