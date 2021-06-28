//
//  NewsStatsView.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import UIKit

class NewsStatsTableViewCell: UITableViewCell {
    var viewData: StatsModel? {
        didSet {
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: NewsTextTableViewCell.classId())

        setupView()
    }

    private func setupView() {}
}
