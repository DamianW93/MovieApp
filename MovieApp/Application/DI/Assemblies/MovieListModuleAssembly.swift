//
//  MovieListModuleAssembly.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import Swinject
import SwinjectAutoregistration
import UIKit

final class MovieListModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(
            MovieListViewModel.self,
            argument: Optional<MovieListDelegate>.self,
            initializer: MovieListViewModel.init
        )

        container.autoregister(
            MovieDetailsViewModel.self,
            arguments: MovieModel.self, (() -> Void).self,
            initializer: MovieDetailsViewModel.init
        )

        container.autoregister(
            CoordinatorProtocol.self,
            name: CoordinatorName.movieListCoordinator.rawValue,
            arguments: UINavigationController.self, MovieListModuleFactoryProtocol.self,
            initializer: MovieListCoordinator.init
        )
    }
}
