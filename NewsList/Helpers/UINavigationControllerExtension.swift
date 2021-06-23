//
//  UINavigationControllerExtension.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import UIKit

extension UINavigationController {
    func startFlow(with vc: UIViewController, style: FlowPresentationStyle) {
        switch style {
        case .replace:
            viewControllers = []
            pushViewController(vc, animated: false)
        case let .push(animated):
            guard
                let currentVC = visibleViewController
            else { return }
            if type(of: currentVC) == type(of: vc) {
                popViewController(animated: false)
            }
            pushViewController(vc, animated: animated)
        }
    }
}
