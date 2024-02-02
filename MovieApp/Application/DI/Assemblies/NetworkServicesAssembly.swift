//
//  NetworkServicesAssembly.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation
import Swinject
import SwinjectAutoregistration

final class NetworkServicesAssembly: Assembly {
    func assemble(container: Container) {
        container
            .register(URLSessionProtocol.self) { _ in URLSession.shared }
            .inObjectScope(.container)

        container
            .register(JSONDecoder.self) { _ in JSONCoder.decoder }
            .inObjectScope(.container)

        container
            .autoregister(NetworkServiceProtocol.self, initializer: NetworkService.init)
            .inObjectScope(.container)
    }
}
