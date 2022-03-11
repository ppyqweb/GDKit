//
//  GDDatePickerView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

@objc public protocol GDDatePickerViewDelegate: class{
    @objc optional func datePickerWillAppear(_ picker: GDDatePickerView)
    @objc optional func datePickerDidAppear(_ picker: GDDatePickerView)
    
    @objc optional func datePicker(_ picker: GDDatePickerView, didPickDate date: Date, dateForString: String, dateWithSecondForString: String)
    @objc optional func datePickerDidCancel(_ picker: GDDatePickerView)
    
    @objc optional func datePickerWillDisappear(_ picker: GDDatePickerView)
    @objc optional func datePickerDidDisappear(_ picker: GDDatePickerView)
}

@objc open class GDDatePickerView: UIView {
    open weak var delegate: GDDatePickerViewDelegate?
    
    /// 中间标题
    open var title: String?
    
    /// 中间标题字体
    open var titleFont: UIFont?
    
    /// 中间标题颜色
    open var titleColor: UIColor?
    
    /// 头部高度
    open var toolbarHeight: CGFloat = 44.0
    
    /// 显示时间的格式
    open var pickerMode: UIDatePicker.Mode = UIDatePicker.Mode.dateAndTime {
        didSet {
            picker.datePickerMode = pickerMode
        }
    }
    
    /// 时间格式
    open var dateFormat: String = "yyyy-MM-dd HH:mm:ss"
    
    fileprivate var toolbar: UIToolbar = UIToolbar()
    fileprivate var picker: UIDatePicker = UIDatePicker()
    
    /// 头部背景颜色
    open var toolbarBackgroundColor: UIColor? {
        didSet {
            toolbar.backgroundColor = toolbarBackgroundColor
            toolbar.barTintColor = toolbarBackgroundColor
        }
    }
    
    
    /// 选择器背景颜色
    open var pickerBackgroundColor: UIColor? {
        didSet { picker.backgroundColor = pickerBackgroundColor }
    }
    
    open var pickerDate: Date = Date() {
        didSet { picker.date = pickerDate }
    }
    
    
    open var minuteInterval: Int {
        set {
            picker.minuteInterval = newValue
        }
        get {
            return picker.minuteInterval
        }
    }
    
    /// 最小日期选择
    open var minimumDate: Date? {
        set {
            picker.minimumDate = newValue
        }
        get {
            return picker.minimumDate
        }
    }
    
    /// 最大日期选择
    open var maximumDate: Date? {
        set {
            picker.maximumDate = newValue
        }
        get {
            return picker.maximumDate
        }
    }
    
    open var leftButtons: [UIBarButtonItem] = []
 
    open var rightButtons: [UIBarButtonItem] = []
    
    
    public override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        
        addSubview(picker)
        addSubview(toolbar)
        
        setupDefaultButtons()
        customize()
        let localeType = NSLocale(localeIdentifier: "zh_CN") //设置为中文显示
        picker.locale = localeType as Locale
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubview(picker)
        addSubview(toolbar)
        
        setupDefaultButtons()
        customize()
    }
    
    fileprivate func setupDefaultButtons() {
        let doneButton = UIBarButtonItem(title: "确定",
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(GDDatePickerView.pressedDone(_:)))
        
        let cancelButton = UIBarButtonItem(title: "取消",
                                           style: UIBarButtonItem.Style.plain,
                                           target: self,
                                           action: #selector(GDDatePickerView.pressedCancel(_:)))
        doneButton.tintColor = UIColor.white
        cancelButton.tintColor = UIColor.white
        leftButtons = [ cancelButton ]
        rightButtons = [ doneButton ]
    }
    
    fileprivate func customize() {
        toolbar.barStyle = UIBarStyle.blackTranslucent
        toolbar.isTranslucent = false
//
//        backgroundColor = UIColor.white
//
//        if let toolbarBackgroundColor = toolbarBackgroundColor {
//            toolbar.backgroundColor = toolbarBackgroundColor
//        } else {
            toolbar.backgroundColor = UIColor.white
//        }
        
        if let pickerBackgroundColor = pickerBackgroundColor {
            picker.backgroundColor = pickerBackgroundColor
        } else {
            picker.backgroundColor = UIColor.white
        }
        
        picker.minimumDate = Date(timeIntervalSinceNow: 60 * 60)
    }
    
    fileprivate func toolbarItems() -> [UIBarButtonItem] {
        var items: [UIBarButtonItem] = []
        
        for button in leftButtons {
            items.append(button)
        }
        
        if let title = toolbarTitle() {
            let spaceLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let spaceRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let titleItem = UIBarButtonItem(customView: title)
            
            items.append(spaceLeft)
            items.append(titleItem)
            items.append(spaceRight)
        } else {
            let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            items.append(space)
        }
        
        for button in rightButtons {
            items.append(button)
        }
        
        return items
    }
    
    fileprivate func toolbarTitle() -> UILabel? {
        if let title = title {
            let label = UILabel()
            label.text = title
            label.font = titleFont
            label.textColor = UIColor.white
            label.sizeToFit()
            
            return label
        }
        
        return nil
    }
    
    open func showPickerInView(_ view: UIView, animated: Bool) {
        toolbar.items = toolbarItems()
        
        toolbar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: toolbarHeight)
        picker.frame = CGRect(x: 0, y: toolbarHeight, width: view.frame.size.width, height: picker.frame.size.height)
        self.frame = CGRect(x: 0, y: view.frame.size.height - picker.frame.size.height - toolbar.frame.size.height,
                            width: view.frame.size.width, height: picker.frame.size.height + toolbar.frame.size.height)
        
        view.addSubview(self)
        becomeFirstResponder()
        
        showPickerAnimation(animated)
    }
    
    open func hidePicker(_ animated: Bool) {
        hidePickerAnimation(true)
    }
    
    fileprivate func hidePickerAnimation(_ animated: Bool) {
        delegate?.datePickerWillDisappear?(self)
        
        if animated {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.frame = self.frame.offsetBy(dx: 0, dy: self.picker.frame.size.height + self.toolbar.frame.size.height)
            }, completion: { (finished) -> Void in
                self.delegate?.datePickerDidDisappear?(self)
            })
        } else {
            self.frame = self.frame.offsetBy(dx: 0, dy: self.picker.frame.size.height + self.toolbar.frame.size.height)
            delegate?.datePickerDidDisappear?(self)
        }
    }
    
    fileprivate func showPickerAnimation(_ animated: Bool) {
        delegate?.datePickerWillAppear?(self)
        
        if animated {
            self.frame = self.frame.offsetBy(dx: 0, dy: self.frame.size.height)
            
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.frame = self.frame.offsetBy(dx: 0, dy: -1 * self.frame.size.height)
            }, completion: { (finished) -> Void in
                self.delegate?.datePickerDidAppear?(self)
            })
        } else {
            delegate?.datePickerDidAppear?(self)
        }
    }
    
    
    @objc open func pressedDone(_ sender: AnyObject) {
        hidePickerAnimation(true)
        
        let dateForString = GDDateHelper.shared.dateConvertString(date: picker.date, dateFormat: dateFormat)
        let localeDate = GDDateHelper.shared.dateLocal(date: picker.date)
        let dateWithSecondForString = GDDateHelper.shared.dateConvertString(date: picker.date, dateFormat: dateFormat)

        delegate?.datePicker?(self, didPickDate: localeDate, dateForString: dateForString, dateWithSecondForString:dateWithSecondForString)
    }
    
    /// Default Cancel actions for picker.
    @objc open func pressedCancel(_ sender: AnyObject) {
        hidePickerAnimation(true)
        
        delegate?.datePickerDidCancel?(self)
    }
}
























