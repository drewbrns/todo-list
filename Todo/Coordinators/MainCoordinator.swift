//
//  MainCoordinator.swift
//  Todo
//
//  Created by Drew Barnes on 29/09/2021.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {

    }

}
