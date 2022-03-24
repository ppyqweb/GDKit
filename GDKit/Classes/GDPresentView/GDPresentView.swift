//
//  GDPresentView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

/// view.tag = 98 由下往上推出
/// view.tag = 99 由frame起点缩放
open class GDPresentView: UIView {
    
    var animated: Bool = true
    
    ///由下往上推出
    @objc public func gd_showView(_ view: UIView, isTapEnabled: Bool = true) {
        self.animated = true
        gd_showView(view, isTapEnabled: isTapEnabled, animated: true)
    }
    
    ///由下往上推出
    @objc public func gd_showView(_ view: UIView, isTapEnabled: Bool = true, animated: Bool) {
        //        self.keyWindow = [[[UIApplication sharedApplication] delegate] window];
        //        self.keyVC = self.keyWindow.rootViewController;
        //        self.frame = self.keyWindow.bounds;
        view.tag = 98
        self.animated = animated
        self.frame = CGRect(x: 0, y: 0, width: k_ScreenWidth, height: k_ScreenHeight)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        UIApplication.shared.keyWindow?.addSubview(self)
        
        let topView = UIView(frame: self.frame)
        self.addSubview(topView)
        topView.height = self.height - view.height
        if isTapEnabled == true {
            let tap = UITapGestureRecognizer(target: self, action: #selector(gd_closeView))
            topView.addGestureRecognizer(tap)
        }
        
        self.addSubview(view)
        view.top = self.height
        if (animated == true) {
            UIView.animate(withDuration: 0.25) {
                view.top = self.height - view.height
            }
        }else{
            view.top = self.height - view.height
        }
        
        
    }
    
    ///由frame为起点缩放
    @objc public func gd_showView(_ view: UIView, frame: CGRect) {
        view.tag = 99
        self.animated = true
        //view.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: 0, height: 0)
        self.frame = CGRect(x: 0, y: 0, width: k_ScreenWidth, height: k_ScreenHeight)
        //self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        UIApplication.shared.keyWindow?.addSubview(self)
        
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: k_ScreenHeight))
        self.addSubview(backView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(gd_closeView))
        backView.addGestureRecognizer(tap)
        backView.isUserInteractionEnabled = false
        
        self.addSubview(view)
        view.frame = frame
        
        if (animated == true) {
            var offsetX = frame.size.width / 2
            if frame.origin.x < (k_ScreenWidth - frame.size.width)/2 {
                offsetX = -frame.size.width / 2
            }
            
            let offsetY = -frame.size.height / 2
            view.transform = __CGAffineTransformMake(0.01, 0, 0, 0.01, offsetX, offsetY)
            //view.layer.anchorPoint = CGPoint(x: 0, y: 0) //锚点
            UIView.animate(withDuration: 0.3) {
                view.alpha = 1.0
                view.transform = __CGAffineTransformMake(1.05, 0, 0, 1.0, 0, 0)
            } completion: { success in
                UIView.animate(withDuration: 0.1) {
                    view.transform = __CGAffineTransformMake(1, 0, 0, 1, 0, 0)
                } completion: { success in
                    //  恢复原位
                    view.transform = CGAffineTransform.identity
                    backView.isUserInteractionEnabled = true
                }
            }
            
        }else{
            view.frame = frame
        }
    }
    
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        self.gd_closeView()
    //    }
    
    
    @objc public func gd_closeView() {
        guard let view = self.subviews.last, self.subviews.count == 2 else {
            self.removeFromSuperview()
            return
        }
        
        if (animated == true) {
            if view.tag == 99 {
                let frame = view.frame
                // 动画由大变小
                view.transform = __CGAffineTransformMake(1, 0, 0, 1, 0, 0)
                UIView.animate(withDuration: 0.2) {
                    var offsetX = frame.size.width / 2
                    if frame.origin.x < (k_ScreenWidth - frame.size.width)/2 {
                        offsetX = -frame.size.width / 2
                    }
                    
                    let offsetY = -frame.size.height / 2
                    view.transform = __CGAffineTransformMake(0.01, 0, 0, 0.01, offsetX, offsetY)
                } completion: { success in
                    view.transform = CGAffineTransform.identity
                    view.alpha = 0.0
                    self.removeFromSuperview()
                }
            } else {
                UIView.animate(withDuration: 0.25, animations: {
                    view.top = self.height
                }) { (finished) in
                    self.removeFromSuperview()
                }
            }
        }else{
            view.top = self.height
            self.removeFromSuperview()
        }
        
    }
}


extension UIView {
    
    @objc public func gd_closeViewToPresentView() {
        if let presentView = self.superview as? GDPresentView {
            presentView.gd_closeView()
        }
    }
}
