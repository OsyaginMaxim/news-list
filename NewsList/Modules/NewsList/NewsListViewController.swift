//
//  NewsListViewController.swift
//  NewsList
//
//  Created by Maxim Osyagin on 19.06.2021.
//

import UIKit

class NewsListViewController: UIViewController, NewsListView, NewsListPresentable {
    var presenter: NewsListViewPresenter?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Navigation

    // MARK: - MediaView

    // MARK: - Events

    // MARK: - Utility

    private func setupView() {
        view.backgroundColor = .yellow
    }
}
