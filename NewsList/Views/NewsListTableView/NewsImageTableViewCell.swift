//
//  NewsImageTableViewCell.swift
//  NewsList
//
//  Created by Maxim Osyagin on 21.06.2021.
//

import UIKit

class NewsImageTableViewCell: UITableViewCell {
    var viewData: ContentModel? {
        didSet {
            fillCell()
        }
    }
    
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: NewsImageTableViewCell.classId())

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(contentImageView)

        NSLayoutConstraint.activate(
            [
                contentImageView.leadingAnchor.constraint(
                    equalTo: contentView.leadingAnchor,
                    constant: 20
                ),
                contentImageView.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor,
                    constant: -20
                ),
                contentImageView.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: 0
                ),
                contentImageView.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: 0
                )
            ]
        )
    }

    private func fillCell() {
        guard
            let imageModel = viewData?.data as? ImageDataModel,
            let urlString = imageModel.actualImage?.url,
            let url = URL(string: urlString)
        else { return }

        contentImageView.load(url: url)
    }
}
