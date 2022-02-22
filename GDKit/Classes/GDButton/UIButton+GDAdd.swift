//
//  UIButton+GDAdd.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

extension UIButton {
    
    public class func gd_button(
        title:String? = nil,
        selectTitle:String? = nil,
        font:UIFont? = nil,
        normalColor: UIColor? = nil,
        selectColor: UIColor? = nil,
        bgNormalColor: UIColor? = nil,
        bgSelectColor: UIColor? = nil,
        lightNormalColor: UIColor? = nil,
        lightSelectColor: UIColor? = nil,
        bgLightNormalColor: UIColor? = nil,
        bgLightSelectColor: UIColor? = nil) -> UIButton {
            
            let btn = UIButton(type: .custom)
            btn.titleLabel?.font = font
            
            btn.setTitle(title, for: .normal)
            btn.setTitle(selectTitle, for: .selected)
            btn.setTitle(title, for: [.highlighted,.normal])
            btn.setTitle(selectTitle, for: [.highlighted,.selected])
            
            
            btn.setTitleColor(normalColor, for: .normal)
            btn.setTitleColor(selectColor, for: .selected)
            btn.setTitleColor(lightNormalColor, for: [.highlighted,.normal])
            btn.setTitleColor(lightSelectColor, for: [.highlighted,.selected])
            
            
            btn.setBackgroundImage(bgNormalColor?.imageWithColor(), for: .normal)
            btn.setBackgroundImage(bgSelectColor?.imageWithColor(), for: .selected)
            btn.setBackgroundImage(bgLightNormalColor?.imageWithColor(), for: [.highlighted,.normal])
            if bgLightNormalColor == nil {
                btn.setBackgroundImage(bgNormalColor?.withAlphaComponent(0.9).imageWithColor(), for: [.highlighted,.normal])
            }
            btn.setBackgroundImage(bgLightSelectColor?.imageWithColor(), for: [.highlighted,.selected])
            if bgLightSelectColor == nil {
                btn.setBackgroundImage(bgSelectColor?.withAlphaComponent(0.9).imageWithColor(), for: [.highlighted,.selected])
            }
            
            return btn
        }
    
}
