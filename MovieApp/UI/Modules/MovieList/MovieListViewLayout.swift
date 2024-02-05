//
//  MovieListViewLayout.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import SnapKit
import UIKit

final class MovieListViewLayout {
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    let informationalLabel = UILabel()

    private let fullScreenLoading = UIActivityIndicatorView(style: .large)

    private let view: UIView

    init(view: UIView) {
        self.view = view

        setup()
    }

    func configureView(for state: MovieListState) {
        fullScreenLoading.isHidden = !state.showFullScreenLoading
        informationalLabel.text = state.informationalMessage

        if state.shouldShowRefreshIndicator {
            refreshControl.beginRefreshing()
        } else {
            refreshControl.endRefreshing()
        }

        tableView.reloadData()
    }
}

extension MovieListViewLayout {
    private func setup() {
        view.backgroundColor = UIColor.secondarySystemBackground

        tableView.register(MovieListCell.self, forCellReuseIdentifier: MovieListCell.reuseIdentifier)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.refreshControl = refreshControl
        tableView.contentInset = .init(top: 16.0, left: 0, bottom: 16.0, right: 0)
        tableView.showsVerticalScrollIndicator = false

        informationalLabel.textAlignment = .center
        informationalLabel.numberOfLines = 0

        fullScreenLoading.startAnimating()

        setupViewHierarchy()
        setupConstraints()
    }

    private func setupViewHierarchy() {
        tableView.addSubview(refreshControl)

        view.addSubview(fullScreenLoading)
        view.addSubview(informationalLabel)
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        fullScreenLoading.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        informationalLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16.0)
        }
    }
}
