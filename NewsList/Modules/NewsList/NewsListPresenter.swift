//
//  NewsListPresenter.swift
//  NewsList
//
//  Created by Maxim Osyagin on 19.06.2021.
//

import Foundation

protocol NewsListPresentable: AnyObject {
    var presenter: NewsListViewPresenter? { get set }
}

class NewsListPresenter: NewsListViewPresenter {
    weak var view: NewsListView?

    required init(view: NewsListView?) {
        self.view = view
    }
}
