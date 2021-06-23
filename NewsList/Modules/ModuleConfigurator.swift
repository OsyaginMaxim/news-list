//
//  ModuleConfigurator.swift
//  NewsList
//
//  Created by Maxim Osyagin on 19.06.2021.
//
import Foundation

class ModuleConfigurator {
    // MARK: - NewsList
    static func createNewsListModule(
        services: NewsFlowServices,
        delegate: NewsListPresenterDelegete
    ) -> (view: NewsListViewController, presenter: NewsListPresenter) {
        let view = NewsListViewController()
        let presenter = NewsListPresenter(view: view, services: services, delegate: delegate)
        view.presenter = presenter

        return (view: view, presenter: presenter)
    }
}
