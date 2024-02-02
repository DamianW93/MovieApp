//
//  MovieListState.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 24/01/2024.
//

import Foundation

enum MovieListState: Equatable {
    case loading
    case loaded
    case refreshing
    case error(String)
    case empty
    case loadingMore
}

extension MovieListState {
    var showFullScreenLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }

    var shouldShowRefreshIndicator: Bool {
        switch self {
        case .refreshing: return true
        default: return false
        }
    }

    var isLoadingData: Bool {
        switch self {
        case .loading, .refreshing, .loadingMore: return true
        default: return false
        }
    }

    var errorMessage: String? {
        switch self {
        case .error(let errorMessage): return errorMessage
        default: return nil
        }
    }
}
