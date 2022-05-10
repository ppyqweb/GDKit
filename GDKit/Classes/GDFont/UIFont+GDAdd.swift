//
//  UIFont+GDAdd.swift
//  GDKit
//
//  Created by SJ on 2022/1/15.
//

import Foundation

public func gd_Font(_ size: CGFloat) -> UIFont {
    let font = UIFont.systemFont(ofSize: size.autoW, weight: .regular)
//    let font = UIFont(name: "PingFangSC-Regular", size: size)!
    return font
}

public func gd_MediumFont(_ size: CGFloat) -> UIFont {
    let font = UIFont.systemFont(ofSize: size.autoW, weight: .medium)
//    let font = UIFont(name: "PingFangSC-Medium", size: size)!
    return font
}

public func gd_BoldFont(_ size: CGFloat) -> UIFont {
    let font = UIFont.systemFont(ofSize: size.autoW, weight: .semibold)
//    let font = UIFont(name: "PingFangSC-Semibold", size: size)!
    return font
}

