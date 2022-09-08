//
//  UITableViewCell+GDTool.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

extension UITableViewCell {
    
    //处理圆角(第一个和最后一个cell添加圆角)
    public func gd_setRounded(indexPath: IndexPath, count: Int, radius: CGFloat = 7, line: UIView? = nil) {
        if count == 1 {
            line?.isHidden = true
            let layer = CAShapeLayer()
            let path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: radius)
            layer.path = path.cgPath
            self.layer.mask = layer
        } else if indexPath.row == 0 {
            line?.isHidden = false
            let layer = CAShapeLayer()
            let path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
            layer.path = path.cgPath
            self.layer.mask = layer
        } else if count - 1 == indexPath.row {
            line?.isHidden = true
            let layer = CAShapeLayer()
            let path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            layer.path = path.cgPath
            self.layer.mask = layer
        } else {
            line?.isHidden = false
            let layer = CAShapeLayer()
            let path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: 0)
            layer.path = path.cgPath
            self.layer.mask = layer
        }
    }
    
}
