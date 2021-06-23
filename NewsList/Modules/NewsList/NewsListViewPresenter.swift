//
//  NewsListViewPresenter.swift
//  NewsList
//
//  Created by Maxim Osyagin on 19.06.2021.
//

import Foundation

protocol NewsListViewPresenter: AnyObject {
    init(
        view: NewsListView?,
        services: NewsFlowServices,
        delegate: NewsListPresenterDelegete
    )

    func loadList()
}
