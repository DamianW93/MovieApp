//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import UIKit
import Combine
import Swinject

protocol AppCoordinatorDelegate: AnyObject {
    func changeRootViewController(to viewController: UIViewController)
}

final class AppCoordinator: BaseCoordinator {
    weak var delegate: AppCoordinatorDelegate?

    private var subscribers = Set<AnyCancellable>()

    private let coordinatorsFactory: CoordinatorsFactoryProtocol
    private let navigationController = UINavigationController()

    init(
        coordinatorsFactory: CoordinatorsFactoryProtocol
    ) {
        self.coordinatorsFactory = coordinatorsFactory
    }

    override func start() {
        rootViewController = navigationController

        openMovieListScreen()
    }

    override func finish() {
        fatalError("Can't close app level coordinator")
    }

    private func openMovieListScreen() {
        let movieListCoordinator = coordinatorsFactory.buildMovieListCoordinator(navigationController: navigationController)

        start(child: movieListCoordinator)

        navigationController.setViewControllers(
            [movieListCoordinator.rootViewController],
            animated: false
        )
    }
}
