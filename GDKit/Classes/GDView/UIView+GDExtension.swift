//
//  UIView+Extension.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation
import UIKit

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
    
    public func setCorners(corners: UIRectCorner, radius: CGFloat) -> Void {
        self.setCorners(corners: corners, radius: radius, rect: self.bounds)
    }
    public func setCorners(corners: UIRectCorner, radius: CGFloat, rect: CGRect) -> Void {
        let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners , cornerRadii: CGSize.init(width: radius, height: radius))
        let layer = CAShapeLayer.init()
        layer.frame = self.bounds
        layer.path = path.cgPath
        self.layer.mask = layer
    }
    
    ///阴影 0.5
    @objc public func gd_shadow(color: UIColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 0.7), offset: CGSize = CGSize(width: 0, height: 1.5), opacity: Float = 1, radius: CGFloat = 3.5) {
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
    
    ///渐变颜色(frame需要有值)
    @objc public func gd_gradient(_ type: ShadowType = .left, colors: [UIColor], locations: [NSNumber]? = nil) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        //设置颜色
        var cgColors: [CGColor] = []
        for color in colors {
            cgColors.append(color.cgColor)
        }
        gradientLayer.colors = cgColors
        
        //设置占比
        if locations == nil {
            let num = 1.0/(Double(colors.count)-1.0)
            var locations: [NSNumber] = []
            for i in 0..<colors.count {
                locations.append(NSNumber(value: num*Double(i)))
            }
            gradientLayer.locations = locations
        } else {
            gradientLayer.locations = locations
        }
        
        //设置位置
        switch type {
        case .all:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        case .top:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            break
        case .left:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            break
        case .right:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
            break
        case .bottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
            break
        }
        self.layer.addSublayer(gradientLayer)
    }

    /// 绘制虚线
    /// - Parameters:
    ///   - lineLength: 长度
    ///   - lineSpacing: 间隔长度
    ///   - lineColor: 颜色
    public func gd_drawDashLine(lineLength: Int, lineSpacing: Int, lineColor: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 1 //描边路径时使用的线宽。默认为1。
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength),NSNumber(value: lineSpacing)]
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.size.width, y: 0))
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
    
}
