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
public let kStatusBarHeight = Float(UIApplication.shared.statusBarFrame.size.height)
///导航条高度
public let kNavigationHeight: Float = 44
///标签栏高度
public let kTabBarHeight: Float = (kStatusBarHeight > 20 ? 83 : 49)
///安全域高度
public let kSafeHeight: Float = (kStatusBarHeight > 20 ? 34 : 0)
///顶部总高度
public let kTopHeight: Float = kStatusBarHeight + kNavigationHeight
///屏幕宽度
public let kScreenWidth = UIScreen.main.bounds.size.width
///屏幕高度
public let kScreenHeight = UIScreen.main.bounds.size.height
///宽度比
public let kScreenWidthScale = kScreenWidth/375.0;
/// 不一定在最前面，像UIWAlert,键盘等
public let kKeyWindow = UIApplication.shared.keyWindow

///设置较小值
public let kMinValue: Float = 0.009

// MARK: - 设备信息相关
///获取Version
public let kVersion = Bundle.main.infoDictionary?.index(forKey: "CFBundleShortVersionString")

// MARK: - 颜色相关
///主题色
public let ThemeColor = "00AF67"
public let ThemeColorRGB : (CGFloat, CGFloat, CGFloat) = (0, 175, 103)
public let ColorPrice = "FF7546"


func kSize(width:CGFloat)->CGFloat{
    return CGFloat(width*(kScreenWidth/375))
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
