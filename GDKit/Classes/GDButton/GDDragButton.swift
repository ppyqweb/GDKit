//
//  GDDragButton.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

///自动拖拽吸附悬浮块
open class GDDragButton: UIButton, UIGestureRecognizerDelegate {
    
    public typealias btnClosure = (_ btn : GDDragButton) ->()
    let ANIMATION_DURATION_TIME = 0.2
    
    //是否可拖拽
    var draggable: Bool = true
    //是否自动吸附
    var autoDocking: Bool = true
    
    //拖拽开始center
    var beginLocation: CGPoint = CGPoint.zero
    
    //单击回调
    var _clickClosure : btnClosure?
    public var clickClosure : btnClosure? {
        get {
            return _clickClosure
        }
        set(newValue) {
            _clickClosure = newValue
            //添加手势操作
            let pan                                            = UIPanGestureRecognizer(target: self, action: #selector(doPanAction(_:)))
            pan.delegate                                       = self
            self.addGestureRecognizer(pan)
            
            //点击手势操作
            let tap                                            = UITapGestureRecognizer(target: self, action: #selector(doTapAction(_:)))
            tap.delegate                                       = self
            self.addGestureRecognizer(tap)
        }
    }
    
    //双击回调
    public var doubleClickClosure : btnClosure?
    //拖拽回调
    public var draggingClosure : btnClosure?
    //拖拽结束回调
    public var dragDoneClosure : btnClosure?
    //自动吸附结束回调
    public var autoDockEndClosure : btnClosure?
    
    //MARK: - 初始化
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 初始化
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //MARK: - 拖拽开始
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first
        if let location = touch?.location(in: self) {
            beginLocation = location
        }
    }
    
    /// 点击事件处理
    @objc func doTapAction(_ sender: UITapGestureRecognizer) {
        //单击被取消 或者 拖拽、 无闭包都不执行
        guard let clickClosure = self.clickClosure else {
            return
        }
        clickClosure(self)
    }
    
    /// 平移拖动操作
    ///
    /// - Parameter sender: 手势
    @objc func doPanAction(_ sender: UIPanGestureRecognizer) {
        if draggable == false {
            return
        }
        
        let currentLocation : CGPoint = sender.location(in: self)
        let offsetX : CGFloat = currentLocation.x - (beginLocation.x)
        let offsetY : CGFloat = currentLocation.y - (beginLocation.y)
        self.center = CGPoint(x: self.center.x+offsetX, y: self.center.y+offsetY)
        
        let superviewFrame: CGRect = self.superview?.frame ?? CGRect.zero
        let frame = self.frame
        let leftLimitX = frame.size.width / 2.0
        let rightLimitX = superviewFrame.size.width - leftLimitX
        let topLimitY = frame.size.height / 2.0 + k_StatusBarHeight
        let bottomLimitY = superviewFrame.size.height - k_TabBarHeight - frame.size.height / 2.0 // - topLimitY
        
        if self.center.x > rightLimitX {
            self.center = CGPoint(x: rightLimitX, y: self.center.y)
        } else if self.center.x <= leftLimitX {
            self.center = CGPoint(x: leftLimitX, y: self.center.y)
        }
        
        if self.center.y > bottomLimitY {
            self.center = CGPoint(x: self.center.x, y: bottomLimitY)
        } else if self.center.y <= topLimitY{
            self.center = CGPoint(x: self.center.x, y: topLimitY)
        }
        //拖拽回调
        guard let draggingClosure = self.draggingClosure else {
            return
        }
        draggingClosure(self)
        
        switch sender.state {
        case .began:
            self.isHighlighted = true
            break
        case .changed:
            self.isHighlighted = true
            break
        case .ended, .cancelled:
            self.isHighlighted = false
            doPanActionEnded()
            break
        default:
            break
        }
        
    }
    //MARK: - 拖拽结束
    func doPanActionEnded() {
        if autoDocking == false {
            return
        }
        
        let superviewFrame: CGRect = self.superview?.frame ?? CGRect.zero
        let frame = self.frame
        let middleX = superviewFrame.size.width / 2.0
        
        if self.center.x >= middleX {
            UIView.animate(withDuration: ANIMATION_DURATION_TIME, animations: {
                self.center = CGPoint(x: superviewFrame.size.width - frame.size.width / 2, y: self.center.y)
                //自动吸附中
            }, completion: { _ in
                //自动吸附结束回调
                guard let autoDockEndClosure = self.autoDockEndClosure else {
                    return
                }
                autoDockEndClosure(self)
            })
        } else {
            
            UIView.animate(withDuration: ANIMATION_DURATION_TIME, animations: {
                self.center = CGPoint(x:frame.size.width / 2, y: self.center.y)
                //自动吸附中
            }, completion: { _ in
                //自动吸附结束回调
                guard let autoDockEndClosure = self.autoDockEndClosure else {
                    return
                }
                autoDockEndClosure(self)
            })
        }
    }
    
    //MARK: - 添加到keyWindow
    func addButtonToKeyWindow() {
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    //MARK: - 移除
    func removeFromKeyWindow() {
        guard let views = UIApplication.shared.keyWindow?.subviews else {
            return
        }
        for view : UIView in views {
            if view.isKind(of: GDDragButton.classForCoder()) {
                view.removeFromSuperview()
            }
        }
    }
    
}
