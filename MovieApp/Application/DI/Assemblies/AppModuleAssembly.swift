//
//  AppModuleAssembly.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import Swinject
import SwinjectAutoregistration

final class AppModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(
            CoordinatorProtocol.self,
            name: CoordinatorName.appCoordinator.rawValue,
            initializer: AppCoordinator.init
        )

        container
            .register(CoordinatorsFactoryProtocol.self, factory: CoordinatorsFactory.init)
            .inObjectScope(.container)

        container.register(WindowControllerProtocol.self) {
            WindowController(
                appCoordinator: $0.resolve(
                    CoordinatorProtocol.self,
                    name: CoordinatorName.appCoordinator.rawValue
                )!
            )
        }
    }
}
