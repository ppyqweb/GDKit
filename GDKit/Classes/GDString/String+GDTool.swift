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
    public static func gd_rounded(_ num: Double) -> String {
        let num = (num * 100.0).rounded()/100.0
        let numInt = Int(num)
        if num - Double(numInt) == 0 {
            return String(numInt)
        }
        return String.init(format: "%.2f", num)
    }
    
    ///四舍五入,始终有小数显示2位小数
    public static func gd_roundedDecimal(_ num: Double) -> String {
        let num = (num * 100.0).rounded()/100.0
        return String.init(format: "%.2f", num)
    }
    
    
    
    ///四舍五入,有小数显示2位小数,无小数显示整数
    public func gd_rounded() -> String {
        var num = Double(self) ?? 0
        num = (num * 100.0).rounded()/100.0
        let numInt = Int(num)
        if num - Double(numInt) == 0 {
            return String(numInt)
        }
        return String.init(format: "%.2f", num)
    }
    
    ///四舍五入,始终有小数显示2位小数
    public func gd_roundedDecimal() -> String {
        var num = Double(self) ?? 0
        num = (num * 100.0).rounded()/100.0
        return String.init(format: "%.2f", num)
    }
    
    ///四舍五入,始终有小数显示2位小数(百分比专用)
    public func gd_roundedDecimalRatio() -> String {
        var num = Double(self) ?? 0
        num = (num * 100.0).rounded()/100.0
        return String.init(format: "%.2f", num) + "%"
    }
    
    ///显示加减号
    public func gd_sign() -> String {
        if self.hasPrefix("-") == true {
            return ""
        } else {
            return "+"
        }
    }
    
    ///数据源元单位
    public func gd_vol() -> String {
        var num = (Double(self) ?? 0) //单位元
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
        var num = (Double(self) ?? 0) //单位股
        num = num / 100
        return String(num).gd_volume()
        /*
         var num = (Double(self) ?? 0) //单位股
         if num >= 100 {
         num = num / 100
         return String(num).gd_volume() + "手"
         }
         return String(num).gd_volume() + "股"
         */
    }
    
    ///数据源股单位
    private func gd_volume() -> String {
        var num = (Double(self) ?? 0) //单位股
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
    
    /*
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
     
     
     ///数据源万元单位
     public func gd_totalMv() -> String {
     var num = (Double(self) ?? 0) * 10000 //单位元
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
     */
    
    
    /// 计算文字的宽高
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - lineSpacing: 行高
    ///   - constraintRect: 大小范围
    /// - Returns: 宽高
    public func gd_sizeWithConstrained(_ font: UIFont,
                                       lineSpacing: CGFloat? = nil,
                                       constraintRect: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> CGSize {
        var attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font]
        if let lineSpacing = lineSpacing {
            //格式调整
            let style = NSMutableParagraphStyle()
            /**调行间距*/
            style.lineSpacing = lineSpacing
            style.alignment = .left
            attributes[.paragraphStyle] = style
        }
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: attributes,
            context: nil)
        return boundingBox.size
    }
    
    public var urlParameters: [String: String] {
        guard let url = URL(string: self) else {
            return [:]
        }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else { return [:] }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
    
}

///正则 Regular
extension String {
    
    ///获取http链接字符串的range
    public func getHttpRangeOfString() -> [NSTextCheckingResult]? {
        let regulaStr = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        do {
            let regex = try NSRegularExpression(pattern: regulaStr, options: .caseInsensitive)
            let arrayOfAllMatches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, self.count))
            return arrayOfAllMatches
        } catch {
            return nil
        }
    }
    
}
