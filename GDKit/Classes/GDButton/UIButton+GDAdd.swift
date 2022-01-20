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
        color:UIColor? = nil,
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
        btn.setTitle(title, for: .normal)
        btn.setTitle(title, for: .highlighted)
        btn.setTitle(title, for: .selected)
        btn.titleLabel?.font = font
        btn.setTitleColor(color, for: .normal)
        btn.setTitleColor(color, for: .highlighted)
        
        //btn.setTitle("登录/注册", for: .normal) //下一步
        //btn.setTitle("登录/注册", for: .selected)
        
        btn.setTitleColor(normalColor, for: .normal)
        btn.setTitleColor(selectColor, for: .selected)
        btn.setBackgroundImage(bgNormalColor?.imageWithColor(), for: .normal)
        btn.setBackgroundImage(bgSelectColor?.imageWithColor(), for: .selected)
        btn.setTitleColor(lightNormalColor, for: [.highlighted,.normal])
        btn.setTitleColor(lightSelectColor, for: [.highlighted,.selected])
        btn.setBackgroundImage(bgLightNormalColor?.imageWithColor(), for: [.highlighted,.normal])
        btn.setBackgroundImage(bgLightSelectColor?.imageWithColor(), for: [.highlighted,.selected])
        return btn
    }
    
}
