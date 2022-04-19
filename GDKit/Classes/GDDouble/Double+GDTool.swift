//
//  Double+GDTool.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

extension Double {
    
    ///四舍五入,有小数显示2位小数,无小数显示整数
    public func gd_rounded() -> String {
        var num = self
        num = (num * 100.0).rounded()/100.0
        let numInt = Int(num)
        if num - Double(numInt) == 0 {
            return String(numInt)
        }
        return String.init(format: "%.2f", num)
    }
    
    ///四舍五入,始终有小数显示2位小数
    public func gd_roundedDecimal() -> String {
        var num = self
        num = (num * 100.0).rounded()/100.0
        return String.init(format: "%.2f", num)
    }
    
    ///四舍五入,始终有小数显示2位小数(百分比专用)
    public func gd_roundedDecimalRatio() -> String {
        var num = self
        num = (num * 100.0).rounded()/100.0
        return String.init(format: "%.2f", num) + "%"
    }
    
    ///显示加减号
    public func gd_sign() -> String {
        if self < 0 {
            return ""
        } else {
            return "+"
        }
    }
    
    ///数据源元单位
    public func gd_vol() -> String {
        var num = self //单位元
        if abs(num) / 1000000000000 > 1 {
            num = num / 1000000000000
            num = (num * 100.0).rounded()/100.0
            return String.init(format: "%.2f万亿", num)
        } else if abs(num) / 100000000 > 1 {
            num = num / 100000000
            num = (num * 100.0).rounded()/100.0
            return String.init(format: "%.2f亿", num)
        } else if abs(num) / 10000 > 1 {
            num = num / 10000
            num = (num * 100.0).rounded()/100.0
            return String.init(format: "%.2f万", num)
        }
        num = (num * 100.0).rounded()/100.0
        return String.init(format: "%.2f", num)
    }
    
    ///数据源元单位
    public func gd_tradeVolume() -> String {
        var num = self //单位股
        num = num / 100
        return num.gd_volume()
    }
    
    ///数据源股单位
    private func gd_volume() -> String {
        var num = self //单位股
        if abs(num) / 1000000000000 > 1 {
            num = num / 1000000000000
            num = (num * 100.0).rounded()/100.0
            return String.init(format: "%.2f万亿", num)
        } else if abs(num) / 100000000 > 1 {
            num = num / 100000000
            num = (num * 100.0).rounded()/100.0
            return String.init(format: "%.2f亿", num)
        } else if abs(num) / 10000 > 1 {
            num = num / 10000
            num = (num * 100.0).rounded()/100.0
            return String.init(format: "%.2f万", num)
        }
        return String.init(format: "%.0f", num)
    }
    
}
