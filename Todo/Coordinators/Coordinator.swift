//
//  Coordinator.swift
//  Todo
//
//  Created by Drew Barnes on 29/09/2021.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
