//
//  NewsListTableView.swift
//  NewsList
//
//  Created by Maxim Osyagin on 20.06.2021.
//

import UIKit

class NewsListTableView: UITableView {
    var viewData: [NewsModel]? {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: CGRect.zero, style: UITableView.Style.grouped)
//        backgroundColor = .white
        setupTable()
        register(
            cells: [
                NewsTextTableViewCell.self,
                NewsImageTableViewCell.self,
                NewsAudioTableViewCell.self,
                NewsVideoTableViewCell.self,
                NewsTagsTableViewCell.self,
                NewsAuthorTableViewCell.self,
                NewsStatsTableViewCell.self
            ]
        )
    }

    private func setupTable() {
        delegate = self
        dataSource = self
    }

    private func renderData() {
        reloadData()
    }
}

extension NewsListTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contentCount = viewData?[safe: section]?.contents?.count else { return 0 }
        return contentCount + 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let viewData = viewData,
            let newsModel = viewData[safe: indexPath.section]
        else { return UITableViewCell() }

        if indexPath.row == 0 {
            let cell = dequeueReusable(cell: NewsAuthorTableViewCell.self, indexPath: indexPath)
            cell.viewData = newsModel.author

            return cell
        }

        if indexPath.row == (newsModel.contents?.count ?? -2) + 2 {

        }

        if let contentModel = newsModel.contents?[safe: indexPath.row - 1] {
            switch contentModel.type {
            case .audio:
                let cell = dequeueReusable(cell: NewsAudioTableViewCell.self, indexPath: indexPath)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)

                return cell
            case .gif, .image:
                let cell = dequeueReusable(cell: NewsImageTableViewCell.self, indexPath: indexPath)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)
                cell.viewData = newsModel.contents?[safe: indexPath.row - 1]

                return cell
            case .tags:
                let cell = dequeueReusable(cell: NewsTagsTableViewCell.self, indexPath: indexPath)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)

                return cell
            case .text:
                let cell = dequeueReusable(cell: NewsTextTableViewCell.self, indexPath: indexPath)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)
                cell.viewData = newsModel.contents?[safe: indexPath.row - 1]

                return cell
            case .video:
                let cell = dequeueReusable(cell: NewsVideoTableViewCell.self, indexPath: indexPath)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)

                return cell
            case .none:
                return UITableViewCell()
            }
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard
            let viewData = viewData,
            let newsModel = viewData[safe: indexPath.section]
        else { return 0 }

        if indexPath.row == 0 {
            return 50
        }

        if indexPath.row == (newsModel.contents?.count ?? -2) + 2 {
            return 50
        }

        if let contentModel = newsModel.contents?[safe: indexPath.row - 1] {
            switch contentModel.type {
            case .audio:
                return 0
            case .gif, .image:
                if
                    let imageModel = contentModel.data as? ImageDataModel,
                    let originWidth = imageModel.original?.size?.width,
                    let originHeight = imageModel.original?.size?.height
                {
                    let ratio = CGFloat(originWidth) / CGFloat(originHeight)
                    let height = frame.width * ratio

                    return height
                }

                return 0
            case .tags:
                return 0
            case .text:
                guard
                    let textModel = contentModel.data as? TextModel,
                    let text = textModel.value
                else { return 0 }

                let textHeight = text.height(withConstrainedWidth: frame.width, font: .systemFont(ofSize: 17))
                if textHeight <= 100 {
                    return textHeight
                }

                return 100
            case .video:
                if
                    let videoModel = contentModel.data as? MediaModel,
                    let preview = videoModel.previewImage,
                    let previewImage = preview.data as? ImageDataModel,
                    let originWidth = previewImage.actualImage?.size?.width,
                    let originHeight = previewImage.actualImage?.size?.height
                {
                    let ratio = CGFloat(originWidth) / CGFloat(originHeight)
                    let height = frame.width * ratio

                    return height
                }
                return 0
            case .none:
                return 0
            }
        }

        return 0
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)

        return ceil(boundingBox.height)
    }
}
