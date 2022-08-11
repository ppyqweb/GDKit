//
//  GDBrowseImageView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

open class GDBrowseImageView: UIView {
    
    // MARK: - constant 常量
    // 位置、大小、图片、文本
    
    
    /// 是否显示删除按钮
    var isShowDelete:Bool = true
    
    var currentPage:Int = 0
    
    public typealias block = (_ index:Int) -> ()
    public var deleteBlock:block?
    
    
    // MARK: - life cycle 生命周期
    //工程的viewDidLoad、viewWillAppear、init、didReceiveMemoryWarning等方法都放在这里
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.clear
        setupBrowseImageView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - view layout 子视图的布局
    //界面布局
    
    func setupBrowseImageView() {
        
        self.addSubview(self.browseScrollview)
        self.addSubview(self.pageController)
        self.addSubview(self.deleteButton)
        
        pageController.frame = CGRect(x: 0, y: 0, width: 150, height: 20)
        pageController.center = self.center
        pageController.bottom = self.bottom - 30
        
        deleteButton.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        deleteButton.right = self.right - 10
        deleteButton.bottom = self.bottom - 10
        
        /*
         pageController.snp.makeConstraints { (make) in
         
         make.centerX.equalTo(self.snp_centerX)
         make.width.equalTo(150)
         make.height.equalTo(20)
         make.bottom.equalTo(-30)
         }
         
         deleteButton.snp.makeConstraints { (make) in
         
         make.right.equalTo(-10)
         make.width.equalTo(60)
         make.height.equalTo(40)
         make.bottom.equalTo(-10)
         }
         */
    }
    
    // MARK: - event response 事件响应包括手势和按钮等
    //事件响应，包含手势、按钮、通知等等事件的处理
    
    @objc func clickedDeleteButton() {
        
        if deleteBlock != nil {
            
            deleteBlock?(currentPage)
        }
    }
    
    
    // MARK: - private method 业务无关的尽量弄成category，方便别人调用
    //没有暴露给外面调用的方法。
    
    
    
    // MARK: - push or pop 控制器
    //控制器跳转处理
    
    
    
    // MARK: - public method 公共方法
    //提供给对外调用的公共方法，一般来说，我的控制器是很少有提供给外界调用的方法，在viewmodel中有比较多的公共方法。
    
    
    /// 显示
    public func showBrowseImageView() {
        
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    /// 影藏
    func hideBrowseImageView() {
        
        self.removeFromSuperview()
    }
    
    
    /// 刷新视图
    ///
    /// - Parameters:
    ///   - array: 图片数组
    ///   - index: 位置
    public func refreshUIImageView(array:Array<UIImageView>,index:Int) {
        
        
        if isShowDelete {
            
            deleteButton.isHidden = false
        }
        else{
            deleteButton.isHidden = true
        }
        
        currentPage = index > array.count - 1 ? array.count - 1 : index
        
        browseScrollview.contentSize = CGSize(width: CGFloat(array.count) * k_ScreenWidth, height: 0)
        browseScrollview.contentOffset = CGPoint(x: CGFloat(currentPage)*k_ScreenWidth, y: 0)
        browseScrollview.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        pageController.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        pageController.numberOfPages = array.count
        pageController.currentPage = self.currentPage
        pageController.refreshUI()
        
        for index in 0..<array.count {
            let imageView:UIImageView = array[safe: index]
            let newFrame:CGRect = imageView.superview?.convert(imageView.frame, to: self) ?? CGRect(x: 0, y: 0, width: 0, height: 0)
            let scrollView:GDBrowseImageScrollView = GDBrowseImageScrollView.init(frame: CGRect(x: browseScrollview.width*CGFloat(index), y: 0, width: browseScrollview.width, height: browseScrollview.height))
            scrollView.tag = 12345+index
            ///初始化位置
            scrollView.setContent(rect: newFrame)
            ///改变位置
            scrollView.setupCurrentCImage(image: imageView.image ?? UIImage())
            ///动画大小
            scrollView.setAnimationRect()
            browseScrollview.addSubview(scrollView)
            scrollView.touchBlock = { (view:GDBrowseImageScrollView) in
                if view.initRect.width == 0 ||
                    view.initRect.height == 0 {
                    self.removeFromSuperview()
                    return
                }
                let imageScrollView:GDBrowseImageScrollView = view
                UIView.animate(withDuration: 0.25, animations: {
                    imageScrollView.rechangeInitRdct()
                }, completion: { (finished) in
                    self.removeFromSuperview()
                })
                
            }
        }
    }
    
    // MARK: - request 请求信息
    //请求处理
    
    
    
    // MARK: - test 存放测试信息
    // 临时的测试信息，都放在这里，便于快速调试。
    
    
    
    // MARK: - getters and setters 构造器
    //get和set方法
    
    lazy var browseScrollview: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    lazy var pageController: GDCustomPageControl = {
        let control = GDCustomPageControl.init(frame: CGRect.zero)
        control.location = GDCustomPageControlType.Center;
        control.backgroundColor = UIColor.clear
        return control
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton.gd_button(title: "删除", font: gd_Font(18), normalColor: UIColor.white)
        button.addTarget(self, action: #selector(clickedDeleteButton), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.isHidden = true
        return button
    }()
}

// MARK: - delegate 具体到某个delegate，比如UITableViewDelegate
//代理或者数据源

extension GDBrowseImageView: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth:CGFloat = scrollView.frame.size.width
        self.currentPage = Int((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        pageController.currentPage = self.currentPage
    }
    
}
