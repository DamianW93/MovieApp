//
//  Assembler.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import Swinject

extension Assembler {
    static func appAssembler() -> Assembler {
        Assembler([
            AppModuleAssembly(),
            FactoriesAssembly(),
            MovieListModuleAssembly(),
            NetworkServicesAssembly(),
            PersistenceAssembly(),
            RepositoriesAssembly()
        ])
    }
}
