//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import Combine
import UIKit

class MovieListViewController: UIViewController {
    let viewModel: MovieListViewModel

    private var layout: MovieListViewLayout!
    private var cancellables = Set<AnyCancellable>()

    private var scrollViewVelocity: CGPoint = .zero

    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movie App"

        setup()
        bindViewModel()

        viewModel.loadData()
    }

    private func setup() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        layout = MovieListViewLayout(view: view)

        layout.tableView.dataSource = viewModel
        layout.tableView.delegate = self
        layout.refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }

    @objc private func didPullToRefresh() {
        viewModel.onPullToRefresh()
    }
}

// MARK: - Bindings

extension MovieListViewController {
    func bindViewModel() {
        viewModel.$itemIndexToUpdate
            .sink { [weak self] indexToUpdate in
                guard let indexToUpdate else { return }

                self?.layout.tableView.reloadRows(
                    at: [IndexPath(row: indexToUpdate, section: 0)],
                    with: .none
                )
            }
            .store(in: &cancellables)

        viewModel.$state
            .sink { [weak self] state in
                guard let self else { return }

                self.layout.configureView(for: state)
             }
            .store(in: &cancellables)
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapMovie(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isCellVisible = (tableView.indexPathsForVisibleRows ?? []).contains(indexPath)
        let contentIsBiggerThanTable = tableView.contentSize.height > tableView.frame.height

        viewModel.willDisplayMovie(
            at: indexPath.row,
            isCellVisible: isCellVisible,
            isContentBiggerThanTable: contentIsBiggerThanTable
        )
    }
}
