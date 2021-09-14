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
        bindVmPublishers()

        title = vm.name

        vm.fetchTodos()
    }

}

// MARK: Setup
extension TodoViewController {

    private func setupTableView() {
        registerCell()
        removeEmptyCellsFromBottom()
    }

    private func registerCell() {
        self.tableView.register(
            UINib(nibName: TodoItemCell.cellId, bundle: nil),
            forCellReuseIdentifier: TodoItemCell.cellId
        )
    }

    private func removeEmptyCellsFromBottom() {
        self.tableView.tableFooterView = UIView()
    }

    private func bindVmPublishers() {
        bindFetchCompletePublisher()
    }

    private func bindFetchCompletePublisher() {
        vm.$onFetchComplete.sink { _ in
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }

}

// MARK: TableView Datasource
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
        if let item = vm.item(at: indexPath.row) {
            cell.configure(with: TodoItemViewModel(
                todoItem: item
            ))
        }
        return cell
    }

}
