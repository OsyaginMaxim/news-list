//
//  NewsTextTableViewCell.swift
//  NewsList
//
//  Created by Maxim Osyagin on 21.06.2021.
//

import UIKit

class NewsTextTableViewCell: UITableViewCell {

    lazy var contentLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    required init?(coder aDecoder: NSCoder) { fatalError() }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: NewsTextTableViewCell.classId())

        setupView()
    }

    private func setupView() {
        contentView.addSubview(contentLabel)
        NSLayoutConstraint.activate(
            [
                contentLabel.leadingAnchor.constraint(
                    equalTo: contentView.leadingAnchor,
                    constant: 20
                ),
                contentLabel.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor,
                    constant: -20
                ),
                contentLabel.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: 10
                ),
                contentLabel.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: -10
                ),
            ]
        )
    }
}

