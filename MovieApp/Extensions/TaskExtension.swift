//
//  TaskExtension.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Combine

extension Task {
    func store(in set: inout Set<AnyCancellable>) {
        set.insert(AnyCancellable(cancel))
    }
}
