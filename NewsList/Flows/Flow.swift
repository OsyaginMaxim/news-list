//
//  Flow.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import UIKit

enum FlowPresentationStyle {
    case replace
    case push(animated: Bool)
}

protocol Flow {
    func start(navigation: UINavigationController, style: FlowPresentationStyle)
}

extension Flow {
    func start(navigation: UINavigationController, style: FlowPresentationStyle) {}
}

enum Flows {
    case news(NewsFlowDelegate, NewsFlowServices)
}

extension Flows {
    var flow: Flow {
        switch self {
        case let .news(d, s): return NewsFlow(services: s, delegate: d)
        }
    }
}

