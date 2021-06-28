//
//  NewsAuthorView.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import UIKit

class NewsAuthorTableViewCell: UITableViewCell {
    var viewData: AuthorModel? {
        didSet {
            fillCell()
        }
    }

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var createdAtLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.textColor = .lightText
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    required init?(coder aDecoder: NSCoder) { fatalError() }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: NewsTextTableViewCell.classId())

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
                avatarImageView.heightAnchor.constraint(equalToConstant: 30),
                avatarImageView.widthAnchor.constraint(equalToConstant: 30),
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

    private func fillCell() {
        guard let author = viewData else { return }

        if
            let photoModel = author.photo,
            let photo = photoModel.data as? ImageDataModel,
            let urlString = photo.small?.url,
            let url = URL(string: urlString)
        {
            avatarImageView.load(url: url)
        }

        nameLabel.text = viewData?.name
    }
}
