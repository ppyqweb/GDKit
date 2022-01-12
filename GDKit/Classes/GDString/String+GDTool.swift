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
    
}
