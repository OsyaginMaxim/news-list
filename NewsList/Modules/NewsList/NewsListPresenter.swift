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

protocol NewsListPresenterDelegete: AnyObject {}

class NewsListPresenter: NewsListViewPresenter {
    weak var view: NewsListView?
    private let services: NewsFlowServices
    weak var delegate: NewsListPresenterDelegete?

    private var cursor: String? {
        didSet {
            if cursor == nil {
                cursor = oldValue
            }
        }
    }

    required init(
        view: NewsListView?,
        services: NewsFlowServices,
        delegate: NewsListPresenterDelegete
    ) {
        self.view = view
        self.services = services
        self.delegate = delegate
    }

    func loadList() {
        services.networking.getNews(first: 10, after: cursor ?? "", orderBy: "createdAt") { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(response):
                self.view?.viewModel = response
            case .failure(_):
                break
            }
        }
    }
}
