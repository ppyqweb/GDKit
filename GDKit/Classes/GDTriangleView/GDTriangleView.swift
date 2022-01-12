//
//  GDTriangleView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

class GDTriangleView: UIView {

    override func draw(_ rect: CGRect) {
        //如何配置颜色?? 背景颜色要在外部设
        let cgcolor:CGColor = self.backgroundColor?.cgColor ?? UIColor.init().cgColor
        self.backgroundColor = UIColor.clear
        self.drawTriangle(cgcolor)
    }
    
    public func drawTriangle(_ color: CGColor) {
        // 获取当前的图形上下文
        let context = UIGraphicsGetCurrentContext()
        // 设置边框颜色
        //            context?.setStrokeColor(UIColor.green.cgColor)
        // 设置填充颜色
        context?.setFillColor(UIColor.gd_get(ThemeColor).cgColor)
        // 开始画线,需要将起点移动到指定的point
        context?.move(to: CGPoint(x: 0, y: 0))
        // 添加一根线到另一个点 (两点一线)
        context?.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height/2.0))
        // 添加一根线到另一个点 (两点一线)
        context?.addLine(to: CGPoint(x: 0, y: self.frame.size.height))

        // 画线完毕,最后将起点和终点封起来
        context?.closePath()
        /*
        stroke      : 边框;
        fill        : 填充
        fillStroke  : 边框 + 填充
        */
        context?.drawPath(using: .fill)
        // 渲染上下文
        context?.strokePath()
    }
}
