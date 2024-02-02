//
//  WindowController.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import UIKit

protocol WindowControllerProtocol {
    func setupWindow(_ window: UIWindow?)
}

final class WindowController: WindowControllerProtocol {
    private var window: UIWindow?
    private var appCoordinator: CoordinatorProtocol

    init(appCoordinator: CoordinatorProtocol) {
        self.appCoordinator = appCoordinator
    }

    func setupWindow(_ window: UIWindow?) {
        self.window = window

        setupAppCoordinator()

        window?.makeKeyAndVisible()
    }

    private func setupAppCoordinator() {
        appCoordinator.start()

        window?.rootViewController = appCoordinator.rootViewController
    }
}
