//
//  NSAttributedString+GDTool.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    public class func gd_create(string str: String, font: UIFont? = nil, color textColor: UIColor? = nil, url: String? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let font = font {
            attributes[.font] = font
        }
        if let textColor = textColor {
            attributes[.foregroundColor] = textColor
        }
        if let url = url {
            //添加链接文本
            attributes[.link] = url
        }
        let attributedString = NSAttributedString(string: str, attributes: attributes)
        return attributedString
    }
    
}
