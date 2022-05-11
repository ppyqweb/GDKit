//
//  GDLayoutMethod.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

struct GDLayoutMethod {
    
    ///横屏情况下的宽度设置
    ///
    /// - Parameters:
    ///   - iPhoneWidth: iPhone6 垂直方向@2x尺寸
    ///   - iPadWidth: 分辨率比例为768*1024的iPad
    /// - Returns: 适配后的尺寸
    
    static func autoLayoutWidth(iPhoneWidth: CGFloat, iPadWidth: CGFloat? = nil) -> CGFloat {
        layoutScale()
        return kLayoutScale * iPhoneWidth
    }
    
    static var kLayoutScale: Double = 1
    
    static func layoutScale() {
        DispatchQueue.once(token: "1") {
            var autoWidth: CGFloat = 0.0
            let normalWidth:CGFloat = 390.0//以iphone6为标准  375 * 667
            let actualwidth = GDLayoutTool.autoScreenWidth//横屏下的屏幕宽度
            
            //iphone的自动布局
            if UIDevice.isIphone {
                autoWidth = actualwidth/normalWidth
                //iPad的自动布局
            } else if UIDevice.isIpad{
                autoWidth = actualwidth/768.0
                /*
                 guard let ipadW = iPadWidth else {
                 autoWidth = actualwidth/768.0
                 return autoWidth
                 }
                 
                 //ipad机器最小屏的屏宽是768
                 autoWidth = ipadW * (actualwidth/768.0)
                 */
            }
            kLayoutScale = autoWidth
        }
    }
    
}

public extension CGFloat {
    ///精确到小数点后几位
    func rounded(_ decimalPlaces: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat.maximum(0, CGFloat(decimalPlaces)))
        return CGFloat((CGFloat(self) * divisor).rounded() / divisor)
    }
}

extension UIDevice {
    
    static let isIphone = UIDevice.current.userInterfaceIdiom == .phone
    
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
}
