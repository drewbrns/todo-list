//
//  TodoViewController.swift
//  Todo
//
//  Created by Drew Barnes on 13/09/2021.
//

import UIKit
import Combine

class TodoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!

    private(set) var vm: TodoItemListViewModel!
    private var cancellables: Set<AnyCancellable> = []

    convenience init(viewModel: TodoItemListViewModel) {
        self.init()
        self.vm = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        bindVm()

        title = vm.name
        vm.fetchTodos()
    }

    private func setupTableView() {
        self.tableView.register(
            UINib(nibName: TodoItemCell.cellId, bundle: nil),
            forCellReuseIdentifier: TodoItemCell.cellId
        )
        self.tableView.tableFooterView = UIView()
    }

    private func bindVm() {
        vm.$onFetchComplete.sink { _ in
            self.tableView.reloadData()
        }.store(in: &cancellables)
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
