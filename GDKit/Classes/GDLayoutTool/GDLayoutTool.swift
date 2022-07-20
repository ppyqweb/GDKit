//
//  GDLayoutTool.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

struct GDLayoutTool{
    ///安全距离的Insets
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
        }
        return .zero
    }
    ///左边安全距离
    static let leftSafeInset = safeAreaInsets.left
    ///右边安全距离
    static let rightSafeInset = safeAreaInsets.right
    ///上边安全距离
    static let topSafeInset = safeAreaInsets.top
    ///下边安全距离
    static let bottomSafeInset = safeAreaInsets.bottom
    
    ///横屏下的屏幕宽度
    static let autoScreenWidth = min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
    
}


///适配手机和平板的宽度
public func autoWidth(_ width: CGFloat) -> CGFloat {
    return GDLayoutMethod.autoLayoutWidth(iPhoneWidth: width)
}
///适配手机和平板的高度
public func autoHeight(_ height: CGFloat) -> CGFloat {
    return GDLayoutMethod.autoLayoutWidth(iPhoneWidth: height)
}

///系统字号
func autoFontSize(_ font: CGFloat) -> UIFont {
    let font : UIFont = UIFont.systemFont(ofSize: font.autoW)
    return font
}
///加粗的系统字号
func autoBoldfontSize(_ font: CGFloat) -> UIFont {
    let font : UIFont = UIFont.boldSystemFont(ofSize: font.autoW)
    return font
}

extension Int {
    public var autoW:CGFloat {
        return autoWidth(CGFloat(self))
    }
    public var autoH:CGFloat {
        return autoHeight(CGFloat(self))
    }
    public var systemFont:UIFont{
        return autoFontSize(CGFloat(self))
    }
    public var boldFont:UIFont{
        return autoBoldfontSize(CGFloat(self))
    }
}

/*
extension Int {
    public var autoW:Int {
        return Int(autoWidth(CGFloat(self)))
    }
    public var autoH:Int {
        return Int(autoHeight(CGFloat(self)))
    }
    public var systemFont:UIFont{
        return autoFontSize(CGFloat(self))
    }
    public var boldFont:UIFont{
        return autoBoldfontSize(CGFloat(self))
    }
}
*/

extension Double {
    public var autoW:Double {
        return Double(autoWidth(CGFloat(self)))
    }
    public var autoH:Double {
        return Double(autoHeight(CGFloat(self)))
    }
    public var systemFont:UIFont{
        return autoFontSize(CGFloat(self))
    }
    public var boldFont:UIFont{
        return autoBoldfontSize(CGFloat(self))
    }
}
extension CGFloat {
    public var autoW:CGFloat {
        return CGFloat(autoWidth(self))
    }
    public var autoH:CGFloat {
        return CGFloat(autoHeight(self))
    }
    public var systemFont:UIFont{
        return autoFontSize(self)
    }
    public var boldFont:UIFont{
        return autoBoldfontSize(self)
    }
    //字体高度
    public var fontHeight: CGFloat {
        return self * 1.193359375
    }
}
extension Float {
    public var autoW:Float {
        return Float(autoWidth(CGFloat(self)))
    }
    public var autoH:Float {
        return Float(autoHeight(CGFloat(self)))
    }
    public var systemFont:UIFont{
        return autoFontSize(CGFloat(self))
    }
    public var boldFont:UIFont{
        return autoBoldfontSize(CGFloat(self))
    }
}
