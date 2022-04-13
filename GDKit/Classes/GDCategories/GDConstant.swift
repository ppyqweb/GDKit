//
//  GDConstant.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

// MARK: - UI相关
///状态栏高度
public let k_StatusBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height)
///导航条高度
public let k_NavigationHeight: CGFloat = 44
///标签栏高度
public let k_TabBarHeight: CGFloat = (k_StatusBarHeight > 20 ? 83 : 49)
///安全域高度
public let k_SafeHeight: CGFloat = (k_StatusBarHeight > 20 ? 34 : 0)
///顶部总高度
public let k_TopHeight: CGFloat = k_StatusBarHeight + k_NavigationHeight
///屏幕宽度
public let k_ScreenWidth = UIScreen.main.bounds.size.width
///屏幕高度
public let k_ScreenHeight = UIScreen.main.bounds.size.height
///宽度比
public let k_ScreenWidthScale = k_ScreenWidth/375.0;
///宽度比
public let k_ScreenScale = k_ScreenWidth/390.0;
/// 不一定在最前面，像UIWAlert,键盘等
public let k_KeyWindow = UIApplication.shared.keyWindow

///设置较小值
public let k_MinValue: Float = 0.009

// MARK: - 设备信息相关
///获取Version
public let k_Version = Bundle.main.infoDictionary?.index(forKey: "CFBundleShortVersionString")

// MARK: - 颜色相关
///主题色
//public let ThemeColor = "00AF67"
//public let ThemeColorRGB : (CGFloat, CGFloat, CGFloat) = (0, 175, 103)
//public let ColorPrice = "FF7546"


func kSize(width:CGFloat)->CGFloat{
    return CGFloat(width*(k_ScreenWidth/375))
}

func cutCorner(cornerRadius:CGFloat,borderWidth:CGFloat,borderColor:UIColor,view:UIView)
{
    view.layer.cornerRadius = cornerRadius
    view.layer.borderColor = borderColor.cgColor
    view.layer.borderWidth = borderWidth
    view.layer.masksToBounds = true
}


//取plist文件
func GD_READ_PLIST(name: String) -> String {
    
    let plistStr:String = Bundle.main.path(forResource: name, ofType: "plist")!
    
    return plistStr
}
