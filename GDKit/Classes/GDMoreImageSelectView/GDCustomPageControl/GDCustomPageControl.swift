//
//  GDCustomPageControl.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit


/// 显示的位置
///
/// - GDCustomPageControlTypeLeft: 左边
/// - GDCustomPageControlTypeMiddle: 中间
/// - GDCustomPageControlTypeRight: 右边
enum GDCustomPageControlType:Int {
    
    case Left = 1
    case Center
    case Right
}

class GDCustomPageControl: UIView {
    
    // MARK: - constant 常量
    // 位置、大小、图片、文本
    
    let buttonTag = 10000
    
    var selectButton:UIButton = UIButton.init()
    
    /// 总共数量
    var numberOfPages:Int = 0
    
    /// 当前位置
    var currentPage:Int = 0
    
    ///  未选中时颜色
    var pageIndicatorTintColor:UIColor = .white
    
    /// 选中时颜色
    var currentPageIndicatorTintColor:UIColor = .red
    /// 位置
    var location:GDCustomPageControlType = GDCustomPageControlType(rawValue: GDCustomPageControlType.Left.rawValue)!
    
    
    
    
    // MARK: - life cycle 生命周期
    //工程的viewDidLoad、viewWillAppear、init、didReceiveMemoryWarning等方法都放在这里
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - view layout 子视图的布局
    //界面布局
    
    
    
    // MARK: - event response 事件响应包括手势和按钮等
    //事件响应，包含手势、按钮、通知等等事件的处理
    
    @objc func clickeDot(button:UIButton) {
        
        selectButton.isSelected = false
        selectButton = button
        selectButton.isSelected = true
    }
    
    
    // MARK: - private method 业务无关的尽量弄成category，方便别人调用
    //没有暴露给外面调用的方法。
    
    
    
    // MARK: - push or pop 控制器
    //控制器跳转处理
    
    
    
    // MARK: - public method 公共方法
    //提供给对外调用的公共方法，一般来说，我的控制器是很少有提供给外界调用的方法，在viewmodel中有比较多的公共方法。
    
    func setupCurrentPage(page:Int) {
        
        currentPage = page;
        
        let button:UIButton = self.viewWithTag(buttonTag + currentPage) as! UIButton
        self.clickeDot(button: button)
        
    }
    
    
    func refreshUI() {
        
        self.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        
        var left:CGFloat = 0
        
        if self.location.rawValue == GDCustomPageControlType.Left.rawValue {
            left = 0
            
        }
        else if self.location.rawValue == GDCustomPageControlType.Right.rawValue {
            
            left = CGFloat(self.width) - 9.0*CGFloat(self.numberOfPages)+4.0
        }
        else {
            
            left = (CGFloat(self.width) - 9.0*CGFloat(self.numberOfPages - 1)+5.0)/2.0
        }
        
        for index in 0..<self.numberOfPages {
            let button = UIButton.gd_button(title: "", font: gd_Font(20))
            button.frame = CGRect(x: left+9.0*CGFloat(index), y: self.frame.size.height/2.0 - 5/2, width: 5, height: 5)
            button.addTarget(self, action: #selector(clickeDot(button:)), for: .touchUpInside)
            button.layer.borderColor = UIColor.color(hex: "e4e4e4").cgColor
            button.layer.borderWidth = 0.5
            button.layer.cornerRadius = 2.5
            button.layer.masksToBounds = true
            button.tag = buttonTag + index
            button.setBackgroundImage(self.pageIndicatorTintColor.imageWithColor(width: button.bounds.size.width, height: button.bounds.size.height), for: UIControl.State.normal)
            button.setBackgroundImage(self.currentPageIndicatorTintColor.imageWithColor(width: button.bounds.size.width, height: button.bounds.size.height), for: UIControl.State.selected)
            if index == currentPage {
                
                selectButton = button
            }
        }
        
    }
    
    // MARK: - request 请求信息
    //请求处理
    
    
    
    // MARK: - test 存放测试信息
    // 临时的测试信息，都放在这里，便于快速调试。
    
    
    
    // MARK: - getters and setters 构造器
    //get和set方法
    
    
    
    // MARK: - delegate 具体到某个delegate，比如UITableViewDelegate
    //代理或者数据源
    
}
