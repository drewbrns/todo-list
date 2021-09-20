//
//  AddTodoViewController.swift
//  Todo
//
//  Created by Drew Barnes on 14/09/2021.
//

import UIKit
import Combine

class AddTodoViewController: UIViewController {

    @IBOutlet var todoItemLabelTextField: PaddedTextField!
    @IBOutlet var todoItemNotesTextView: PaddedTextView!
    @IBOutlet var todoItemDueDatePicker: UIDatePicker!
    @IBOutlet var submitButton: UIButton!

    private var header: String?
    private(set) var vm: AddTodoItemViewModel!
    private var cancellables: Set<AnyCancellable> = []

    convenience init(title: String, viewModel: AddTodoItemViewModel) {
        self.init()
        self.header = title
        self.vm = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = header

        setupDatePicker()
        bindOnAddItem()
        bindOnError()
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        vm.addTodo(
            label: todoItemLabelTextField.text,
            dueDate: todoItemDueDatePicker.date,
            notes: todoItemNotesTextView.text
        )
    }

    private func setupDatePicker() {
        todoItemDueDatePicker.minimumDate = Date()
    }

    private func bindOnAddItem() {
        vm.$onAddItem.sink { _ in

        }.store(in: &cancellables)
    }

    private func bindOnError() {
        vm.$onError.sink { _ in

        }.store(in: &cancellables)
    }
}
