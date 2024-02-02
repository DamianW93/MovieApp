//
//  BaseCoordinator.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    /// Force unwrapped because each coordinator has to have root UIViewController,
    /// thought it could be assigned outside constructor.
    var rootViewController: UIViewController! { get }
    var parentCoordinator: CoordinatorProtocol? { get set }
    var childCoordinators: [CoordinatorProtocol] { get }
    var viewController: UIViewController? { get set }

    func start()
    func finish()
    func start(child: CoordinatorProtocol)
    func finish(child: CoordinatorProtocol)
}

class BaseCoordinator: CoordinatorProtocol {
    var rootViewController: UIViewController!
    var parentCoordinator: CoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol] = []
    var viewController: UIViewController?

    func start() {
        fatalError("Start method for Coordinator should be implemented! Do not call super.start()!")
    }

    func start(child: CoordinatorProtocol) {
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()

        print("Started child coordinator: \(child)")
    }

    func finish() {
        let children = childCoordinators
        children.forEach { $0.finish() }

        parentCoordinator?.finish(child: self)
    }

    func finish(child: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)

            print("Finished child coordinator: \(child)")
        }
    }
}
