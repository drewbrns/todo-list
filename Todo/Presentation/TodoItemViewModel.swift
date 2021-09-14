//
//  TodoItemViewModel.swift
//  Todo
//
//  Created by Drew Barnes on 13/09/2021.
//

import Foundation

struct TodoItemViewModel {
    private(set) var todoItem: TodoItem

    var label: String {
        todoItem.label
    }

    var notes: String? {
        todoItem.notes
    }

    var dueDate: String? {
        todoItem.dueDate.stringForDisplay(longFormat: "EEEE, MMM d, yyyy")
    }

    var isComplete: Bool {
        todoItem.isComplete
    }
}
