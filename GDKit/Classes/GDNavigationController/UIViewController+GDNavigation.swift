//
//  UIViewController+GDNavigation.swift
//  GDKit
//
//  Created by SJ on 2022/1/15.
//

import UIKit

extension UIViewController {
    
    public func gd_config() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.gd_setupNavigationAttributed()
        self.gd_setupTitleAttributed()
        self.gd_setupLeftButton(title: "", color: .black)
    }
    
    
    ///设置导航条属性
    func gd_setupNavigationAttributed() {
        //设置状态栏
        //UIApplication.shared.statusBarStyle = .default
        //self.preferredStatusBarStyle = .default
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIColor.red.imageWithColor(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIColor.blue.imageWithColor()
    }
    
    
    ///设置标题属性
    func gd_setupTitleAttributed() {
        let titleDict = [NSAttributedString.Key.font: gd_BoldFont(16), NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
    }
    
    
    ///返回按钮
    func gd_setupLeftButton(title: String, color: UIColor) {
        
        let image = UIImage(named: "icon_back")?.withRenderingMode(.alwaysTemplate)
        
        let leftButton = UIButton(type: .custom)
        leftButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        leftButton.titleLabel?.font = gd_Font(16)
        leftButton.addTarget(self, action: #selector(onCallBackAction), for: .touchUpInside)
        leftButton.setTitle(title, for: .normal)
        leftButton.setTitleColor(color, for: .normal)
        leftButton.setImage(image, for: .normal)
        leftButton.contentHorizontalAlignment = .left
        leftButton.tintColor = color
        let leftItem = UIBarButtonItem(customView: leftButton)
        
        let negativeSeperator = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSeperator.width = -0
        self.navigationItem.leftBarButtonItems = [negativeSeperator,leftItem]
    }
    
    
    ///返回按钮响应
    @objc func onCallBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func gd_setupRightButton(title: String, color: UIColor, image: UIImage) {
        
        let image = image.withRenderingMode(.alwaysOriginal)
        
        let rightButton = UIButton(type: .custom)
        rightButton.frame = CGRect(x: 0, y: 0, width: 70, height: 44)
        rightButton.titleLabel?.font = gd_Font(28)
        rightButton.addTarget(self, action: #selector(onClickedNavRight), for: .touchUpInside)
        rightButton.setTitle(title, for: .normal)
        rightButton.setTitleColor(color, for: .normal)
        rightButton.setImage(image, for: .normal)
        rightButton.contentHorizontalAlignment = .right
        let rightItem = UIBarButtonItem(customView: rightButton)
        
        let negativeSeperator = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSeperator.width = -0
        self.navigationItem.rightBarButtonItems = [negativeSeperator,rightItem]
    }
    
    @objc func onClickedNavRight() {
        
    }
    
    
}

