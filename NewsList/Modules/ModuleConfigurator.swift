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
//        services: MainFlowServices,
//        delegate: MainPresenterDelegete
    ) -> (view: NewsListViewController, presenter: NewsListPresenter) {
        let view = NewsListViewController()
        let presenter = NewsListPresenter(view: view)
        view.presenter = presenter

        return (view: view, presenter: presenter)
    }
}
