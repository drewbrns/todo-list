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

        setupTableView()

        title = vm.name
        vm.fetchTodos()
    }

    private func setupTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.register(
            TodoItemCell.self, forCellReuseIdentifier: TodoItemCell.cellId
        )
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

        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TodoItemCell.cellId,
                for: indexPath
        ) as? TodoItemCell else {
            fatalError("Expected TodoItemCell")
        }
        
        return cell
    }

}
