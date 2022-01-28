//
//  String+GDTool.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

extension String {
    
    ///四舍五入,有小数显示2位小数,无小数显示整数
    static func gd_rounded(_ num: Double) -> String {
        let num = (num * 100.0).rounded()/100.0
        let numInt = Int(num)
        if num - Double(numInt) == 0 {
            return String(numInt)
        }
        return String.init(format: "%.2f", num)
    }
    
    ///四舍五入,始终有小数显示2位小数
    static func gd_roundedDecimal(_ num: Double) -> String {
        let num = (num * 100.0).rounded()/100.0
        return String.init(format: "%.2f", num)
    }
    
    
    
    ///四舍五入,有小数显示2位小数,无小数显示整数
    public func gd_rounded() -> String {
        var num = Double(self.replacingOccurrences(of: "-", with: "")) ?? 0
        num = (num * 100.0).rounded()/100.0
        let numInt = Int(num)
        if num - Double(numInt) == 0 {
            return String(numInt)
        }
        return String.init(format: "%.2f", num)
    }
    
    ///四舍五入,始终有小数显示2位小数
    public func gd_roundedDecimal() -> String {
        var num = Double(self.replacingOccurrences(of: "-", with: "")) ?? 0
        num = (num * 100.0).rounded()/100.0
        return String.init(format: "%.2f", num)
    }
    
    ///四舍五入,始终有小数显示2位小数(百分比专用)
    public func gd_roundedDecimalRatio() -> String {
        var num = Double(self.replacingOccurrences(of: "-", with: "")) ?? 0
        num = (num * 1.0).rounded()/100.0
        return String.init(format: "%.2f", num) + "%"
    }
    
    ///显示加减号
    public func gd_sign() -> String {
        if self.hasPrefix("-") == true {
            return "-"
        } else {
            return "+"
        }
    }
    
    ///数据源千元单位
    public func gd_amount() -> String {
        var num = (Double(self) ?? 0) * 1000 //单位元
        if num / 1000000000000 > 1 {
            num = num / 1000000000000
            num = (num * 100.0).rounded()/100.0
            return String.init(format: "%.2f万亿", num)
        } else if num / 100000000 > 1 {
            num = num / 100000000
            num = (num * 100.0).rounded()/100.0
            return String.init(format: "%.2f亿", num)
        } else if num / 10000 > 1 {
            num = num / 10000
            num = (num * 100.0).rounded()/100.0
            return String.init(format: "%.2f万", num)
        }
        num = (num * 100.0).rounded()/100.0
        return String.init(format: "%.2f", num)
    }
    
    
}
