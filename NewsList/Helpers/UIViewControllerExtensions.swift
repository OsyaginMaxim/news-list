//
//  UIViewControllerExtensions.swift
//  NewsList
//
//  Created by Maxim Osyagin on 23.06.2021.
//

import UIKit

extension UIViewController {
    var visibleController: UIViewController {
        switch self {
        case is UINavigationController:
            return (self as? UINavigationController)?.visibleViewController ?? self
        case is UITabBarController:
            return (self as? UITabBarController)?.selectedViewController ?? self
        default:
            return presentedViewController ?? self
        }
    }
}

