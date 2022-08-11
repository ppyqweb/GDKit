//
//  MBProgressHUD+GDAdd.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit
import MBProgressHUD

//使用MBProgressHUD
extension UIView {
    
    /// 显示消息
    ///
    /// - Parameter title: 消息
    public func showText(_ title: String, image: String = "") {
        self.hideLoadView()
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        if image.count > 0,
           let img = UIImage(named: image) {
            hud.customView = UIImageView(image: img) //自定义视图显示图片
        }
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 2)
        self.config(hud)
    }
    
    /// 显示加载中消息
    ///
    /// - Parameter title: 消息
    public func showWait(_ title: String) {
        self.hideLoadView()
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        self.config(hud)
    }
    
    /// 隐藏消息
    public func hideWait() {
        hideLoadView()
    }
    
    /// 显示普通消息
    ///
    /// - Parameter title: 消息
    public func showInfo(_ title: String) {
        self.hideLoadView()
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "info_28_28")!) //自定义视图显示图片
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 2)
        self.config(hud)
    }
    
    /// 显示成功消息
    ///
    /// - Parameter title: 消息
    public func showSuccess(_ title: String) {
        self.hideLoadView()
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "success_28_28")!) //自定义视图显示图片
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 2)
        self.config(hud)
    }
    
    /// 显示失败消息
    ///
    /// - Parameter title: 消息
    public func showError(_ title: String) {
        self.hideLoadView()
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "error_28_28")!) //自定义视图显示图片
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 2)
        self.config(hud)
        hud.minSize = CGSize(width: 155, height: 157)
    }
    
    /// 显示加载动画
    public func showLoadView() {
        self.hideLoadView()
        var imageArray = [UIImage]()
        for i in 0...10 {
            let str = String(format: "loading_%02d_33_33", i)
            imageArray.append(UIImage(named: str)!)
        }
        
        let imageView = UIImageView(image: imageArray.last)
        imageView.animationImages = imageArray
        imageView.animationDuration = 1.5
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
        
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .customView
        hud.customView = imageView
        hud.bezelView.color = UIColor.white.withAlphaComponent(0.1)
        hud.removeFromSuperViewOnHide = true
        self.config(hud)
    }
    
    func config(_ hud: MBProgressHUD) {
        //hud.hide(animated: true, afterDelay: 2)

        hud.margin = 18
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor.color(hex: "FFFFFF") //提示框颜色
        //hud.minSize = CGSize(width: 50, height: 50) //最小Size
        hud.isUserInteractionEnabled = true
        hud.contentColor = UIColor.color(hex: "516471")
        hud.label.font = gd_BoldFont(17) //字体颜色
        hud.label.numberOfLines = 0
        hud.backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.4) //背景颜色
    }
    
    /// 隐藏加载动画
    public func hideLoadView() {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    // 获取当前控制器
    func getCurrentVC() -> UIViewController? {
        
        var window: UIWindow? = (UIApplication.shared.delegate?.window)!
//        let result = window?.rootViewController

        var result: UIViewController? = nil

        if window?.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for tmpWin: UIWindow in windows {
                if tmpWin.windowLevel == UIWindow.Level.normal {
                    window = tmpWin
                    break
                }
            }
        }
        
        if window?.subviews.count != nil {
            let frontView: UIView? = window?.subviews[safe: 0]
            let nextResponder = frontView?.next
            if (nextResponder is UIViewController) {
                result = nextResponder as? UIViewController
            } else {
                result = window?.rootViewController
            }
        } else {
            result = window?.rootViewController
        }
        
        return result
////
//        if let nav = result as? UINavigationController {
//
//            return nav.topViewController
//        }
//        else {
//            return result
//        }
    }
}

//使用MBProgressHUD
extension MBProgressHUD {
    
    /// 显示消息
    ///
    /// - Parameter title: 消息
    public class func showText(_ title: String, image: String = "") {
        let view = viewToShow()
        view.showText(title, image:image)
    }
    
    /// 显示加载中消息
    ///
    /// - Parameter title: 消息
    public class func showWait(_ title: String) {
        let view = viewToShow()
        view.showWait(title)
    }
    
    /// 隐藏消息
    public class func hideWait() {
        hideLoadView()
    }
    
    /// 显示普通消息
    ///
    /// - Parameter title: 消息
    public class func showInfo(_ title: String) {
        let view = viewToShow()
        view.showInfo(title)
    }
    
    /// 显示成功消息
    ///
    /// - Parameter title: 消息
    public class func showSuccess(_ title: String) {
        let view = viewToShow()
        view.showSuccess(title)
    }
    
    /// 显示失败消息
    ///
    /// - Parameter title: 消息
    public class func showError(_ title: String) {
        let view = viewToShow()
        view.showError(title)
    }
    
    /// 显示加载动画
    public class func showLoadView() {
        let view = viewToShow()
        view.showLoadView()
    }
    
    /// 隐藏加载动画
    public class func hideLoadView() {
        let view = viewToShow()
        view.hideLoadView()
    }
    
    //获取用于显示提示框的view
    public class func viewToShow() -> UIView {
        
        if let window = UIApplication.shared.delegate?.window as? UIWindow {
            return window
        }
        
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windowArray = UIApplication.shared.windows
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindow.Level.normal {
                    window = tempWin;
                    break
                }
            }
        }
        return window!
    }
}



extension UIImage {
    /// 颜色转图片
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(origin: CGPoint.zero, size: size)
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        context?.setShouldAntialias(true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        guard let cgImage = image?.cgImage else {
            self.init()
            return nil
        }
        self.init(cgImage: cgImage)
    }
}



extension UIColor {
    
    /// 16进制字符串转颜色
    ///
    /// - Parameters:
    ///   - hexString: 16进制字符串
    ///   - alpah: 透明度
    /// - Returns: 生成的颜色
    public static func colorWithHexString(hexString: String, alpah: CGFloat = 1.0) -> UIColor {
        var cString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            cString = String(cString[cString.index(after: cString.startIndex)..<cString.endIndex])
        }
        if cString.count != 6 {
            return UIColor.black;
        }
        
        let rString = cString[..<cString.index(cString.startIndex, offsetBy: 2)]
        let gString = cString[cString.index(cString.startIndex, offsetBy: 2)..<cString.index(cString.startIndex, offsetBy: 4)]
        let bString = cString[cString.index(cString.endIndex, offsetBy: -2)..<cString.endIndex]
        
        var r: CUnsignedInt = 0
        var g: CUnsignedInt = 0
        var b: CUnsignedInt = 0
        
        Scanner(string: String(rString)).scanHexInt32(&r)
        Scanner(string: String(gString)).scanHexInt32(&g)
        Scanner(string: String(bString)).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpah)
    }
}

