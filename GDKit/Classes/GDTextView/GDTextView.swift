//
//  GDTextView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

open class GDTextView: UITextView {
    
    // MARK: - constant 常量
    // 位置、大小、图片、文本
    
    public var placeholder: String = "" {
        didSet {
            self.placeholderLabel.text = placeholder
            self.placeholderLabel.sizeToFit()
        }
    } //!< 占位文本文本
    
    public var placeholderColor: UIColor = UIColor() {
        didSet {
            self.placeholderLabel.textColor = placeholderColor
        }
    } //!< 占位文本颜色
    
    open override var font: UIFont? {
        didSet {
            self.placeholderLabel.font = font
            self.placeholderLabel.sizeToFit()
        }
    }
    
    open override var text: String? {
        didSet {
            self.placeholderLabel.isHidden = self.hasText
        }
    }
    
    open override var attributedText: NSAttributedString? {
        didSet {
            self.placeholderLabel.isHidden = self.hasText
        }
    }
    
    // MARK: - life cycle 生命周期
    //工程的viewDidLoad、viewWillAppear、init、didReceiveMemoryWarning等方法都放在这里
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupDefautl()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - view layout 子视图的布局
    //界面布局
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.placeholderLabel.frame = CGRect(x: 5, y: 8, width: self.frame.width - 2 * 5, height: 0)
        self.placeholderLabel.sizeToFit()
    }
    
    
    // MARK: - event response 事件响应包括手势和按钮等
    //事件响应，包含手势、按钮、通知等等事件的处理
    
    
    
    // MARK: - private method 业务无关的尽量弄成category，方便别人调用
    //没有暴露给外面调用的方法。
    
    func setupDefautl() {
        // 设置默认字体
        //self.font = gd_Font(14)
        // 设置默认颜色
        //self.placeholderColor = UIColor.color(hex: "999999")
        // 设置默认占位文本
        self.placeholder = ""
        
        // 创建label
        self.addSubview(self.placeholderLabel)
        
        // 使用通知监听文字改变
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    
    // MARK: - push or pop 控制器
    //控制器跳转处理
    
    
    
    // MARK: - public method 公共方法
    //提供给对外调用的公共方法，一般来说，我的控制器是很少有提供给外界调用的方法，在viewmodel中有比较多的公共方法。
    
    @objc func textDidChange(_ notification: Notification) {
        self.placeholderLabel.isHidden = self.hasText
    }
    
    // MARK: - request 请求信息
    //请求处理
    
    
    
    // MARK: - test 存放测试信息
    // 临时的测试信息，都放在这里，便于快速调试。
    
    
    
    // MARK: - getters and setters 构造器
    //get和set方法
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - delegate 具体到某个delegate，比如UITableViewDelegate
    //代理或者数据源
    
    
    
}
