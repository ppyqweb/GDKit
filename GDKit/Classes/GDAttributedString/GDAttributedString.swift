//
//  GDAttributedString.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

class GDAttributedString: NSObject {

    
   /// 获取金额类型的格式化样式
   ///
   /// - Parameter amount: 金额数字
   /// - Returns: 返回金额的富文本
   class func getAmountAttributedString(amount:String) -> NSMutableAttributedString {
        
    let amounts:String = String(format: "%0.2f", (amount as NSString).floatValue)
    let startRang = amounts.range(of: ".")!
    let symbol =  amounts[...startRang.lowerBound]
    let point =  amounts[startRang.upperBound...]
    
    let pointFront:String = String(symbol)
    let pointForward:String = String(point)
    
    let attributedStrM : NSMutableAttributedString = NSMutableAttributedString()
    let symbolStr = NSAttributedString.init(string: "￥", attributes: [NSAttributedString.Key.font : UIFont.gd_fontFor26(), NSAttributedString.Key.foregroundColor : UIColor.gd_get("FD7D28")])
    let pointFrontStr = NSAttributedString.init(string: pointFront, attributes: [NSAttributedString.Key.font : UIFont.gd_boldFontFor36(), NSAttributedString.Key.foregroundColor : UIColor.gd_get("FD7D28")])
    let pointForwardStr = NSAttributedString.init(string: pointForward, attributes: [NSAttributedString.Key.font : UIFont.gd_boldFontFor26(), NSAttributedString.Key.foregroundColor : UIColor.gd_get("FD7D28")])
    attributedStrM.append(symbolStr)
    attributedStrM.append(pointFrontStr)
    attributedStrM.append(pointForwardStr)
    
    return attributedStrM
    }
    
    /// 获取金额类型的格式化样式
    ///
    /// - Parameter amount: 金额数字
    /// - Returns: 返回金额的富文本
    class func getAmountAttributedStringAuto(tips:String,amount:String, titleColor:UIColor, titleFont:UIFont,pointFrontFont:UIFont,pointFrontColor:UIColor, pointNextFont:UIFont,pointNextClolor:UIColor) -> NSMutableAttributedString {
         
     let amounts:String = String(format: "%0.2f", (amount as NSString).floatValue)
     let startRang = amounts.range(of: ".")!
     let symbol =  amounts[...startRang.lowerBound]
     let point =  amounts[startRang.upperBound...]
     
     let pointFront:String = String(symbol)
     let pointForward:String = String(point)
     
     let attributedStrM : NSMutableAttributedString = NSMutableAttributedString()
     let symbolStr = NSAttributedString.init(string: tips, attributes: [NSAttributedString.Key.font : titleFont, NSAttributedString.Key.foregroundColor : titleColor])
     let pointFrontStr = NSAttributedString.init(string: pointFront, attributes: [NSAttributedString.Key.font : pointFrontFont, NSAttributedString.Key.foregroundColor : pointFrontColor])
     let pointForwardStr = NSAttributedString.init(string: pointForward, attributes: [NSAttributedString.Key.font : pointNextFont, NSAttributedString.Key.foregroundColor : pointNextClolor])
     attributedStrM.append(symbolStr)
     attributedStrM.append(pointFrontStr)
     attributedStrM.append(pointForwardStr)
     
     return attributedStrM
     }
}
