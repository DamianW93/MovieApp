//
//  PersistenceAssembly.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Swinject
import SwinjectAutoregistration

final class PersistenceAssembly: Assembly {
    func assemble(container: Container) {
        container
            .autoregister(UserDefaultsServiceProtocol.self, initializer: UserDefaultsService.init)
            .inObjectScope(.container)
    }
}
