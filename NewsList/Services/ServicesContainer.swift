//
//  ServicesContainer.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import Foundation

protocol ServiceContainer {
    var news: NewsFlowServices { get }
}

struct BaseNewsFlowServices: NewsFlowServices {
    var networking: ApiManager
    var player: Player
}

class BaseServiceContainer: ServiceContainer {
    lazy var networking: ApiManager = ApiManager.shared
    lazy var player: Player = Player()

    var news: NewsFlowServices {
        return BaseNewsFlowServices(
            networking: networking,
            player: player
        )
    }
}
