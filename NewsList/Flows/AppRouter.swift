//
//  AppRouter.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import UIKit

class AppRouter {
    private var flows: [Flow] = []

    private var lastOpennedFlowIndex = 0 {
        didSet { logOpenFlow() }
    }

    var currentFlow: Flow {
        return flows[lastOpennedFlowIndex]
    }

    var visibleController: UIViewController? {
        return window.rootViewController?.visibleController
    }

    private let window: UIWindow
    private var rootNavigation: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    func start(
        flow: Flows,
        style: FlowPresentationStyle = .replace,
        isNewFlow: Bool = false
    ) {
        var flowObject = flow.flow

        var flowsMutated = false
        for flowInArray in flows where type(of: flowInArray) == type(of: flowObject) && !isNewFlow {
            flowObject = flowInArray
            flowsMutated = true
        }
        if !flowsMutated { flows.append(flowObject) }
        if let index = flows.firstIndex(where: { type(of: $0) == type(of: flowObject) }) {
            lastOpennedFlowIndex = index
        }

        startFlowInRoot(flow: flowObject, style: style)
    }

    private func logOpenFlow() {
        FlowLogger.log(event: .open, typeOfFlow: type(of: currentFlow), actualFlowArr: flows)
    }

    private func logCloseFlow(_ type: Flow.Type) {
        FlowLogger.log(event: .close, typeOfFlow: type, actualFlowArr: flows)
    }

    func makeWindowKeyAndVisible() {
        window.makeKeyAndVisible()
    }

    private func startFlowInRoot(flow: Flow, style: FlowPresentationStyle) {
        guard let navigation = rootNavigation else {
            prepareRootNavigation()
            startFlowInRoot(flow: flow, style: style)
            return
        }
        flow.start(navigation: navigation, style: style)
        window.rootViewController = navigation
    }

    private func prepareRootNavigation() {
        rootNavigation = UINavigationController.init()
    }
}

enum FlowLogger: String {
    case open = "was openned.", close = "was closed."

    private static var info: String {
        return "[⌚\(Date())][FlowController]"
    }

    static func log(event: FlowLogger, typeOfFlow: Flow.Type, actualFlowArr: [Flow]) {
        let logEvent = "\(FlowLogger.info) \(typeOfFlow) \(event.rawValue)"
        let logActialArr = "\(FlowLogger.info) \(actualFlowArr)"
        print(logEvent)
        print(logActialArr)
    }
}
