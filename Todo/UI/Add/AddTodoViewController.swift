//
//  AddTodoViewController.swift
//  Todo
//
//  Created by Drew Barnes on 14/09/2021.
//

import UIKit

class AddTodoViewController: UIViewController {

    @IBOutlet var todoItemLabelTextField: PaddedTextField!
    @IBOutlet var todoItemNotesTextView: PaddedTextView!
    @IBOutlet var todoItemDueDatePicker: UIDatePicker!
    @IBOutlet var submitButton: UIButton!

    private var header: String?

    convenience init(title: String) {
        self.init()
        self.header = title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = header
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
    }

}
