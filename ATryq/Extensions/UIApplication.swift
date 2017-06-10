//
//  UIApplication.swift
//  GooTaxi
//
//  Created by Bassem on 11/21/16.
//  Copyright © 2017 ADLANC.COM. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func present(_ viewController: UIViewController, animated: Bool = true) {
        UIApplication.shared.topViewController!.present(viewController, animated: animated)
    }
}

extension UIApplication{
    var topViewController: UIViewController?{
        if keyWindow?.rootViewController == nil{
            return keyWindow?.rootViewController
        }
        
        var pointedViewController = keyWindow?.rootViewController
        
        while  pointedViewController?.presentedViewController != nil {
            switch pointedViewController?.presentedViewController {
            case let navagationController as UINavigationController:
                pointedViewController = navagationController.viewControllers.last
            case let tabBarController as UITabBarController:
                pointedViewController = tabBarController.selectedViewController
            default:
                pointedViewController = pointedViewController?.presentedViewController
            }
        }
        return pointedViewController
        
    }
}
