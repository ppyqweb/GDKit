//
//  CAShapeLayer+GDTool.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

extension CAShapeLayer {
    
    ///创建六边形
    public class func gd_hexagon(width: Double) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: sin(M_1_PI / 180 * 60) * (width / 2), y: (width / 4)))
        path.addLine(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width - sin(M_1_PI / 180 * 60) * (width / 2), y: width / 4))
        path.addLine(to: CGPoint(x: width - sin(M_1_PI / 180 * 60) * (width / 2), y: (width / 2) + (width / 4)))
        path.addLine(to: CGPoint(x: width / 2, y: width))
        path.addLine(to: CGPoint(x: sin(M_1_PI / 180 * 60) * (width / 2), y: (width / 2) + (width / 4)))
        path.close()
        let layer = CAShapeLayer()
        //layer.fillColor = UIColor.red.cgColor
        layer.path = path.cgPath
        return layer
    }
    
}


extension CATextLayer {
    
    ///创建Label
    public class func gd_Text(text: String, font: UIFont, color: UIColor, numberOfLines: Int = 0, alignment: CATextLayerAlignmentMode = .left) -> CATextLayer {
        let label = CATextLayer()
        label.string = text
        label.font = CGFont.init("PingFangSC-Regular" as CFString)
        label.fontSize = font.pointSize
        label.foregroundColor = color.cgColor
        //label.numberOfLines = numberOfLines
        label.alignmentMode = alignment
        label.contentsScale = UIScreen.main.scale
        
        let fontSize = text.gd_sizeWithConstrained(font)
        label.frame = CGRect(x: 0, y: 0, width: fontSize.width, height: fontSize.height)
        
        return label
    }
    
    
}
