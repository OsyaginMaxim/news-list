//
//  NewsAudioTableViewCell.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import UIKit

class NewsAudioTableViewCell: UITableViewCell {
    var viewData: MediaModel? {
        didSet {
            fillCell()
        }
    }
    private lazy var playButton: UIButton = {
        let button = UIButton()

        return button
    }()

    private lazy var progress: ProgressSlider = {
        let progress = ProgressSlider()
        progress.minimumValue = 0.0

        return progress
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    required init?(coder aDecoder: NSCoder) { fatalError() }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: NewsTextTableViewCell.classId())

        setupView()
    }

    private func setupView() {

    }

    private func fillCell() {

    }
}
