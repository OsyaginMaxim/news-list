//
//  NewsListViewController.swift
//  NewsList
//
//  Created by Maxim Osyagin on 19.06.2021.
//

import UIKit

class NewsListViewController: UIViewController, NewsListView, NewsListPresentable {
    private lazy var tableView: NewsListTableView = {
        let table = NewsListTableView()
        table.translatesAutoresizingMaskIntoConstraints = false

        return table
    }()

    var viewData: NewsResponse? {
        didSet {
            tableView.viewData = viewData?.data?.items
        }
    }
    var presenter: NewsListViewPresenter?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.loadList()
    }

    // MARK: - Navigation

    // MARK: - MediaView

    // MARK: - Events

    // MARK: - Utility

    private func setupView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
}
