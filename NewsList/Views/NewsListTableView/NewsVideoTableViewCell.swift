//
//  NewsVideoTableViewCell.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import UIKit

class NewsVideoTableViewCell: UITableViewCell {
    var viewData: ContentModel? {
        didSet {
            fillCell()
        }
    }

    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "playSmall"), for: .normal)

        return button
    }()

    required init?(coder aDecoder: NSCoder) { fatalError() }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: NewsTextTableViewCell.classId())

        setupView()
    }

    private func setupView() {
        contentView.addSubview(previewImageView)
        contentView.addSubview(playButton)

        NSLayoutConstraint.activate(
            [
                previewImageView.leadingAnchor.constraint(
                    equalTo: contentView.leadingAnchor,
                    constant: 20
                ),
                previewImageView.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor,
                    constant: -20
                ),
                previewImageView.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: 0
                ),
                previewImageView.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: 0
                ),
                playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                playButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                playButton.heightAnchor.constraint(equalToConstant: 30),
                playButton.widthAnchor.constraint(equalToConstant: 30)
            ]
        )
    }

    private func fillCell() {
        guard
            let viewData = viewData,
            let model = viewData.data as? MediaModel,
            let previewImage = model.previewImage,
            let imageModel = previewImage.data as? ImageDataModel,
            let urlString = imageModel.actualImage?.url,
            let url = URL(string: urlString)
        else { return }

        previewImageView.load(url: url)
    }
}
