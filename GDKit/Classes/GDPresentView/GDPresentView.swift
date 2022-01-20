//
//  GDPresentView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

class GDPresentView: UIView {
    
    var animated: Bool = true
    
    @objc func gd_showView(_ view: UIView, isTapEnabled: Bool = true) {
        self.animated = true
        gd_showView(view, isTapEnabled: isTapEnabled, animated: true)
    }
    
    @objc func gd_showView(_ view: UIView, isTapEnabled: Bool = true, animated: Bool) {
        //        self.keyWindow = [[[UIApplication sharedApplication] delegate] window];
        //        self.keyVC = self.keyWindow.rootViewController;
        //        self.frame = self.keyWindow.bounds;
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
    
    
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        self.gd_closeView()
    //    }
    
    
    @objc func gd_closeView() {
        guard let view = self.subviews.last, self.subviews.count == 2 else {
            self.removeFromSuperview()
            return
        }
        
        if (animated == true) {
            UIView.animate(withDuration: 0.25, animations: {
                view.top = self.height
            }) { (finished) in
                self.removeFromSuperview()
            }
        }else{
            view.top = self.height
            self.removeFromSuperview()
        }
        
    }
}


extension UIView {
    
    @objc func gd_closeViewToPresentView() {
        if let presentView = self.superview as? GDPresentView {
            presentView.gd_closeView()
        }
    }
}
