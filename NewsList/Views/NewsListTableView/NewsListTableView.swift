//
//  NewsListTableView.swift
//  NewsList
//
//  Created by Maxim Osyagin on 20.06.2021.
//

import UIKit

class NewsListTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }

    var newsContents: [ContentModel]? {
        didSet {
            if let newsContents = newsContents {
                rowsArray = newsContents.compactMap {
                    $0.type
                }
            }
        }
    }

    private var rowsArray: [ContentType] = [] {
        didSet {
            reloadData()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: CGRect.zero, style: UITableView.Style.plain)
        backgroundColor = .white
        setupTable()
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
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
