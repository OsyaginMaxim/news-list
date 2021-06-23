//
//  NewsFlow.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import Foundation
import UIKit

protocol NewsFlowServices {
    var networking: ApiManager { get }
    var player: Player { get }
}

protocol NewsFlowDelegate: AnyObject {}

class NewsFlow: Flow {
    var newsList: NewsListViewController?

    private let services: NewsFlowServices
    private weak var delegate: NewsFlowDelegate?

    var navigation: UINavigationController?

    init(services: NewsFlowServices, delegate: NewsFlowDelegate? = nil) {
        self.delegate = delegate
        self.services = services
    }

    func start(navigation: UINavigationController, style: FlowPresentationStyle) {
        self.navigation = navigation

        newsList = ModuleConfigurator.createNewsListModule().view

        self.navigation?.startFlow(with: newsList!, style: .replace)
    }
}
