//
//  NewsAuthorView.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import UIKit

class NewsAuthorView: UIView {
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var createdAtLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.textColor = .lightText
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    required init?(coder aDecoder: NSCoder) { fatalError() }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    private func setupView() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(createdAtLabel)

        NSLayoutConstraint.activate(
            [
                avatarImageView.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: 20
                ),
                avatarImageView.trailingAnchor.constraint(
                    equalTo: nameLabel.leadingAnchor,
                    constant: -20
                ),
                avatarImageView.topAnchor.constraint(
                    equalTo: topAnchor,
                    constant: 10
                ),
                avatarImageView.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -10
                ),
                nameLabel.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -20
                ),
                nameLabel.topAnchor.constraint(
                    equalTo: topAnchor,
                    constant: 10
                ),
                nameLabel.bottomAnchor.constraint(
                    equalTo: createdAtLabel.topAnchor,
                    constant: -10
                ),
                createdAtLabel.leadingAnchor.constraint(
                    equalTo: nameLabel.leadingAnchor,
                    constant: 0
                ),
                createdAtLabel.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -20
                ),
                createdAtLabel.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -10
                ),
            ]
        )
    }
}
