//
//  UIView+Extension.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

extension UIView {
    @objc public enum ShadowType: Int {
        case all = 0 ///四周
        case top  = 1 ///上方
        case left = 2///左边
        case right = 3///右边
        case bottom = 4///下方
    }
    ///默认设置：黑色阴影, 阴影所占视图的比例
   // func shadow(_ type: ShadowType, percent: Float) {
       // shadow(type: type, color: .black, opactiy: 0.4, //shadowSize: 4)
    //}
    ///默认设置：黑色阴影
    @objc func shadow(_ type: ShadowType) {
        shadow(type: type, color: .black, opactiy: 0.1, shadowSize: 4)
    }
    ///阴影设置
    @objc public func shadow(type: ShadowType, color: UIColor,  opactiy: Float, shadowSize: CGFloat) -> Void {
        layer.masksToBounds = false;//必须要等于NO否则会把阴影切割隐藏掉
        layer.shadowColor = color.cgColor;// 阴影颜色
        layer.shadowOpacity = opactiy;// 阴影透明度，默认0
        layer.shadowOffset = .zero;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
        layer.shadowRadius = 3 //阴影半径，默认3
        var shadowRect: CGRect?
        switch type {
        case .all:
            shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: bounds.size.width + 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
        case .top:
            shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: bounds.size.width + 2 * shadowSize, height: 2 * shadowSize)
        case .bottom:
            shadowRect = CGRect.init(x: -shadowSize, y: bounds.size.height - shadowSize, width: bounds.size.width + 2 * shadowSize, height: 2 * shadowSize)
        case .left:
            shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
        case .right:
            shadowRect = CGRect.init(x: bounds.size.width - shadowSize, y: -shadowSize, width: 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
        }
        layer.shadowPath = UIBezierPath.init(rect: shadowRect!).cgPath
    }
    
    func setCorners(corners: UIRectCorner, radius: CGFloat) -> Void {
        self.setCorners(corners: corners, radius: radius, rect: self.bounds)
    }
    func setCorners(corners: UIRectCorner, radius: CGFloat, rect: CGRect) -> Void {
        let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners , cornerRadii: CGSize.init(width: radius, height: radius))
        let layer = CAShapeLayer.init()
        layer.frame = self.bounds
        layer.path = path.cgPath
        self.layer.mask = layer
    }
    
    ///阴影
    @objc public func gd_shadow(color: UIColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 0.5), offset: CGSize = CGSize(width: 0, height: 1.5), opacity: Float = 1, radius: CGFloat = 3.5) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    ///内阴影
    @objc public func gd_innerShadow() {
        self.layer.shadowColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 0.5).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 3
    }
    
}
