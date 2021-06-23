//
//  NewsListCollectionViewCell.swift
//  NewsList
//
//  Created by Maxim Osyagin on 20.06.2021.
//

import UIKit

class NewsListCollectionViewCell: UICollectionViewCell {
    private lazy var tableView = NewsListTableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tableView)

        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ]
        )
    }
}
