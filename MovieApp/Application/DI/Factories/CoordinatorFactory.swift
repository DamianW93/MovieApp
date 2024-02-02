//
//  CoordinatorFactory.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import Foundation
import UIKit

protocol CoordinatorsFactoryProtocol {
    func buildMovieListCoordinator(navigationController: UINavigationController) -> CoordinatorProtocol
}

final class CoordinatorsFactory: DIFactory, CoordinatorsFactoryProtocol {
    func buildMovieListCoordinator(navigationController: UINavigationController) -> CoordinatorProtocol {
        resolver.resolve(
            CoordinatorProtocol.self,
            name: CoordinatorName.movieListCoordinator.rawValue,
            arguments: navigationController, resolver.resolve(MovieListModuleFactoryProtocol.self)!
        )!
    }
}
