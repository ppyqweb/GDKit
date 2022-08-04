//
//  UIViewController+GDAdd.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

extension UIViewController {
    
    ///获取当前VC
    public class func getCurrentVC() -> UIViewController? {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }
        let currentVC = self.getCurrentVCFrom(rootViewController)
        return currentVC
    }
    
    private class func getCurrentVCFrom(_ rootVC: UIViewController) -> UIViewController? {
        var rootVC = rootVC
        let currentVC: UIViewController?
        
        if let presentedVC = rootVC.presentedViewController {
            // 视图是被presented出来的
            rootVC = presentedVC
        }
        
        if let rootVC = rootVC as? UITabBarController,
           let selectedVC = rootVC.selectedViewController {
            // 根视图为UITabBarController
            currentVC = self.getCurrentVCFrom(selectedVC)
            
        } else if let rootVC = rootVC as? UINavigationController,
                  let visibleVC = rootVC.visibleViewController {
            // 根视图为UINavigationController
            currentVC = self.getCurrentVCFrom(visibleVC)
            
        } else {
            // 根视图为非导航类
            currentVC = rootVC;
        }
        
        return currentVC
    }
}
