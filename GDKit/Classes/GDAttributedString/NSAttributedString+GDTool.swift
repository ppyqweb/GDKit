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
    
    public class func gd_create(string str: String, font: UIFont? = nil, color textColor: UIColor? = nil, url: String? = nil, lineSpacing: CGFloat? = nil) -> NSAttributedString {
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
        if let lineSpacing = lineSpacing {
            //格式调整
            let style = NSMutableParagraphStyle()
            /**调行间距*/
            style.lineSpacing = lineSpacing
            style.alignment = .left
            attributes[.paragraphStyle] = style
        }
        let attributedString = NSAttributedString(string: str, attributes: attributes)
        return attributedString
    }
    
    public class func gd_create(image: UIImage) -> NSAttributedString {
        let textAttachment = NSTextAttachment()
        textAttachment.image = image
        let attrStringWithImage = NSAttributedString(attachment: textAttachment)
        return attrStringWithImage
    }
    
}


extension NSAttributedString {
    
    /// 富文本转html字符串
    public class func attriToStr(attri: NSAttributedString) -> String {
        let tempDic: [NSAttributedString.DocumentAttributeKey : Any] =
        [NSAttributedString.DocumentAttributeKey.documentType:
            NSAttributedString.DocumentType.html,
         NSAttributedString.DocumentAttributeKey.characterEncoding:
            String.Encoding.utf8.rawValue]
        do {
            let htmlData = try attri.data(from: NSRange(location: 0, length: attri.length-1), documentAttributes: tempDic)
            return String(data: htmlData, encoding: String.Encoding.utf8) ?? ""
        } catch {
            return ""
        }
    }
    
    /// 字符串转富文本
    public class func strToAttri(htmlStr: String) -> NSAttributedString {
        guard let data = htmlStr.data(using: String.Encoding.unicode) else {
            return NSAttributedString()
        }
        do {
            let attri = try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            return attri
        } catch {
            return NSAttributedString()
        }
    }
    
}


extension NSMutableAttributedString {
    
    public func setStyle(lineSpacing: CGFloat) {
        //格式调整
        let style = NSMutableParagraphStyle()
        /**调行间距*/
        style.lineSpacing = lineSpacing
        style.alignment = .left
        self.addAttributes([NSAttributedString.Key.paragraphStyle : style], range: NSRange(location: 0, length: self.string.count))
    }
    
}
