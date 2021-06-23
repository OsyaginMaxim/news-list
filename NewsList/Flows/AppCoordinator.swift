//
//  AppCoordinator.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import Foundation
import UIKit

class AppCoordinator {
    private lazy var services: ServiceContainer = BaseServiceContainer()
    private let router: AppRouter
    private var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.router = AppRouter(window: window)
    }

    func handle(
        app: UIApplication,
        finishedLaunching options: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        start()
    }

    func start() {
        router.start(flow: .news(self, services.news))
        router.makeWindowKeyAndVisible()
    }
}

extension AppCoordinator: NewsFlowDelegate {}
