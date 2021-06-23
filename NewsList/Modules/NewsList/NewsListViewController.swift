//
//  NewsListViewController.swift
//  NewsList
//
//  Created by Maxim Osyagin on 19.06.2021.
//

import UIKit

class NewsListViewController: UIViewController, NewsListView, NewsListPresentable {
    var viewModel: NewsResponse? {
        didSet {
            print(viewModel)
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
        view.backgroundColor = .yellow
    }
}
