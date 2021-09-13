//
//  TodoViewController.swift
//  Todo
//
//  Created by Drew Barnes on 13/09/2021.
//

import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!

    private(set) var vm: TodoItemListViewModel!

    convenience init(viewModel: TodoItemListViewModel) {
        self.init()
        self.vm = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = vm.name
        vm.fetchTodos()
    }

}

extension TodoViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()
    }

}
