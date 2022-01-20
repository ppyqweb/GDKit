//
//  UIView+GDFrame.swift
//  GDKit
//
//  Created by SJ on 2022/1/15.
//

import Foundation

extension UIView {
    //let cOrigin: CGPoint //!< 位置
    //let cSize: CGSize //!< 大小
    
    open var height: CGFloat {
        get {
            return self.frame.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    } //!< 高度
    
    open var width: CGFloat {
        get {
            return self.frame.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    } //!< 宽度
    
    open var top: CGFloat {
        get {
            return self.frame.minY
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    } //!< 上
    
    open var left: CGFloat {
        get {
            return self.frame.minX
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    } //!< 左
    
    open var bottom: CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue - self.frame.height
            self.frame = frame
        }
    } //!< 下
    
    open var right: CGFloat {
        get {
            return self.frame.maxX
        }
        set {
            var frame = self.frame;
            frame.origin.x = newValue - self.frame.width
            self.frame = frame
        }
    } //!< 右
    
}
