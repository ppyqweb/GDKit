//
//  GDPageTitleView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

// MARK:- 定义协议
@objc public protocol GDPageTitleViewDelegate : AnyObject {
    
    
    /// 点击标题回调
    ///
    /// - Parameters:
    ///   - titleView: GDPageTitleView
    ///   - index: 标题tag
    func classTitleView(_ titleView : GDPageTitleView, selectedIndex index : Int)
    
    func classTitleViewCurrentIndex(_ titleView : GDPageTitleView, currentIndex index : Int)
}

/// 滚动条高度
private let kScrollLineH : CGFloat = 2
/// 默认颜色
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (102, 102, 102)
/// 选中颜色
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (51, 51, 51)
/// 滚动条颜色
private let kBottomLineColor : (CGFloat, CGFloat, CGFloat) = (240, 240, 240)

private let kWhiteColor : (CGFloat, CGFloat, CGFloat) = (255, 255, 255)


open class GDPageTitleView: UIView {
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    @objc public weak var delegate : GDPageTitleViewDelegate?
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        //        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate var lineWidth:CGFloat
    fileprivate var lineHeight:CGFloat
    fileprivate var lineColor:UIColor?
    fileprivate var lineBottomSpace:CGFloat
    fileprivate var font:UIFont
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        if let lineColor = self.lineColor {
            scrollLine.backgroundColor = lineColor
        } else {
            scrollLine.backgroundColor = UIColor(r: self.titleNormalColor.0, g: self.titleNormalColor.1, b: self.titleNormalColor.2)
        }
        scrollLine.layer.cornerRadius = self.lineHeight/2
        scrollLine.layer.masksToBounds = true
        return scrollLine
    }()
    
    
    fileprivate lazy var backView : UIView = {
        let view = UIView(frame: self.scrollView.bounds)
        self.scrollView.addSubview(view)
        return view
    }()
    
    var cellWidth:CGFloat = 0
    var cellSpace:CGFloat = 20
    fileprivate var scale:CGFloat = 0
    /// 默认颜色
    private var titleNormalColor : (CGFloat, CGFloat, CGFloat) = kNormalColor
    /// 选中颜色
    private var titleSelectColor : (CGFloat, CGFloat, CGFloat) = kSelectColor
    /// 默认背景颜色
    private var normalBackgroundColor : (CGFloat, CGFloat, CGFloat) = kWhiteColor
    /// 选中背景颜色
    private var selectBackgroundColor : (CGFloat, CGFloat, CGFloat) = kWhiteColor
    /// 标题选中字形
    private var titleSelectFont : UIFont = UIFont.boldSystemFont(ofSize: 14)
    ///是否隐藏底部分离线
    private var isHiddenSeparator: Bool = false
    ///scrollView是否居中显示
    private var isCenter: Bool = false
    private var itemCornerRadius: CGFloat = 0 ///item圆角
    
    /// 初始化
    /// - Parameters:
    ///   - frame: CGRect
    ///   - titles: 标题
    ///   - lineWidth: 滚动条宽度
    ///   - lineHeight: 滚动条高度
    ///   - lineBottomSpace: 滚动条底部间隔
    ///   - lineColor: 滚动条颜色
    ///   - font: 字体
    ///   - cellWidth: cell宽度
    ///   - cellSpace: cell间隔
    ///   - scale: 缩放比例
    ///   - titleNormalColor: 标题默认颜色
    ///   - titleSelectColor: 标题选中颜色
    ///   - normalBackgroundColor: 标题默认背景颜色
    ///   - selectBackgroundColor: 标题选中背景颜色
    ///   - currentIndex: 当前选中下标
    ///   - isHiddenSeparator: 是否隐藏底部分割线
    ///   - titleSelectFont: 标题选中字形
    ///   - isCenter: 是否居中
    ///   - itemCornerRadius: item圆角
    @objc public init(frame: CGRect,
               titles:[String],
               lineWidth: CGFloat,
               lineHeight: CGFloat,
               lineBottomSpace: CGFloat,
               lineColor: UIColor?,
               font: UIFont?,
               cellWidth:CGFloat,
               cellSpace:CGFloat,
               scale:CGFloat,
               titleNormalColor:[CGFloat]?,
               titleSelectColor:[CGFloat]?,
               normalBackgroundColor:[CGFloat]?,
               selectBackgroundColor:[CGFloat]?,
               currentIndex:Int = 0,
               isHiddenSeparator: Bool = false,
               titleSelectFont: UIFont? = nil,
               isCenter: Bool = false,
               itemCornerRadius: CGFloat = 0) {
        self.titles = titles
        self.lineWidth = lineWidth // == 0 ? 50 : lineWidth
        self.lineHeight = lineHeight // == 0 ? 2 : lineHeight
        self.lineBottomSpace = lineBottomSpace
        self.lineColor = lineColor
        self.font = font == nil ? UIFont.boldSystemFont(ofSize: 14) : font!
        self.cellWidth = cellWidth
        self.cellSpace = cellSpace // == 0 ? 20 : cellSpace
        self.scale = scale
        if let titleNormalColor = titleNormalColor,
            titleNormalColor.count == 3 {
            self.titleNormalColor = (titleNormalColor[0],titleNormalColor[1],titleNormalColor[2])
        }else{
            self.titleNormalColor = kNormalColor
        }
        
        
        if let titleSelectColor = titleSelectColor,
            titleSelectColor.count == 3 {
            self.titleSelectColor = (titleSelectColor[0],titleSelectColor[1],titleSelectColor[2])
        }else{
            self.titleSelectColor = kSelectColor
        }
        
        
        if let normalBackgroundColor = normalBackgroundColor,
            normalBackgroundColor.count == 3 {
            self.normalBackgroundColor = (normalBackgroundColor[0],normalBackgroundColor[1],normalBackgroundColor[2])
        }else{
            self.normalBackgroundColor = kWhiteColor
        }
        
        if let selectBackgroundColor = selectBackgroundColor,
            selectBackgroundColor.count == 3 {
            self.selectBackgroundColor = (selectBackgroundColor[0],selectBackgroundColor[1],selectBackgroundColor[2])
        }else{
            self.selectBackgroundColor = kWhiteColor
        }
        
        self.isHiddenSeparator = isHiddenSeparator
        self.isCenter = isCenter
        self.itemCornerRadius = itemCornerRadius
        if titles.count > currentIndex && currentIndex >= 0 {
            self.currentIndex = currentIndex
        }
        if let titleSelectFont = titleSelectFont {
            self.titleSelectFont = titleSelectFont
        } else {
            self.titleSelectFont = self.font
        }
        super.init(frame: frame)
        // 设置UI界面
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup() {
        scrollLine.isHidden = true
    }
    
    public func setScrollLine(isHidden: Bool) {
        scrollLine.isHidden = isHidden
    }
    
    public func isScrollEnabled(_ isScrollEnabled: Bool) {
        scrollView.isScrollEnabled = isScrollEnabled
    }
    
    public func setNone() {
        self.titleLabelClick(UITapGestureRecognizer())
    }
    
    var tapGesList = [UITapGestureRecognizer]()
    @objc public func moveToLast() {
        if let tapGes = tapGesList.last {
            titleLabelClick(tapGes)
        }
    }
    
    @objc public func changedTitle(title: String, index: Int) {
        if titleLabels.count <= index {
            return
        }
        let label: UILabel = titleLabels[index]
        label.text = title;
    }
    
}


extension GDPageTitleView {
    fileprivate func setupUI() {
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应的Label
        setupTitleLabels()
        
        // 3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
        
    }
    
    fileprivate func setupTitleLabels(){
        var contentWidth:CGFloat = 0
        // 0.确定label的一些frame的值
        //        let labelW : CGFloat = frame.width / CGFloat(titles.count > count ? count : titles.count)
        //        let labelW : CGFloat = 120
        let labelH : CGFloat = frame.height - lineHeight;
        let labelY : CGFloat = 0
        var labelX : CGFloat = cellSpace
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = font
            label.numberOfLines = 2
            label.textColor = UIColor(r: self.titleNormalColor.0, g: self.titleNormalColor.1, b: self.titleNormalColor.2)
            label.backgroundColor = UIColor(r: self.normalBackgroundColor.0, g: self.normalBackgroundColor.1, b: self.normalBackgroundColor.2)
            label.textAlignment = .center
            label.sizeToFit()
            
            let width = cellWidth == 0 ? label.bounds.width : cellWidth
            
            label.frame = CGRect(x: labelX, y: labelY, width: width, height: labelH)
            backView.addSubview(label)
            labelX = label.frame.maxX + cellSpace
            contentWidth = labelX
            titleLabels.append(label)
            
            if itemCornerRadius > 0 {
                label.layer.cornerRadius = itemCornerRadius
                label.layer.masksToBounds = true
            }

            // 5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            tapGesList.append(tapGes)
        }
        var backViewFrame = backView.frame
        backViewFrame.size.width = contentWidth
        backView.frame = backViewFrame
        scrollView.contentSize = CGSize(width: contentWidth, height: bounds.height)
        if self.bounds.size.width > contentWidth && isCenter == true {
            backView.bounds.origin.x = (self.bounds.size.width - contentWidth)/2
        }
        
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        
        if isHiddenSeparator == false {
            let bottomLine = UIView()
            bottomLine.backgroundColor = UIColor(r: kBottomLineColor.0, g: kBottomLineColor.1, b: kBottomLineColor.2)
            let lineH : CGFloat = 0.5
            bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
            addSubview(bottomLine)
        }
        
        // 2.添加scrollLine
        // 2.1.获取第一个Label
        guard self.currentIndex < titleLabels.count else {
            return
        }
        let firstLabel = titleLabels[self.currentIndex]
        //        guard let firstLabel = titleLabels.first else { return }
        firstLabel.font = titleSelectFont
        firstLabel.textColor = UIColor(r: self.titleSelectColor.0, g: self.titleSelectColor.1, b: self.titleSelectColor.2)
        firstLabel.backgroundColor = UIColor(r: self.selectBackgroundColor.0, g: self.selectBackgroundColor.1, b: self.selectBackgroundColor.2)
        firstLabel.transform = CGAffineTransform(scaleX: 1 + scale, y: 1 + scale)
        
        // 2.2.设置scrollLine的属性
        backView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - lineHeight - lineBottomSpace, width: lineWidth, height: lineHeight)
        //        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - lineH, width: firstLabel.frame.width/2.5, height: lineH)
        scrollLine.center.x = firstLabel.center.x
    }
}

// MARK:- 监听Label的点击
extension GDPageTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        
        // 0.获取当前Label
        let currentLabel = tapGes.view as? UILabel ?? UILabel()
        
        // 2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag != currentIndex {
            
            currentLabel.font = titleSelectFont
            oldLabel.font = font
            // 3.切换文字的颜色
            currentLabel.textColor = UIColor(r: self.titleSelectColor.0, g: self.titleSelectColor.1, b: self.titleSelectColor.2)
            currentLabel.backgroundColor = UIColor(r: self.selectBackgroundColor.0, g: self.selectBackgroundColor.1, b: self.selectBackgroundColor.2)
            oldLabel.textColor = UIColor(r: self.titleNormalColor.0, g: self.titleNormalColor.1, b: self.titleNormalColor.2)
            oldLabel.backgroundColor = UIColor(r: self.normalBackgroundColor.0, g: self.normalBackgroundColor.1, b: self.normalBackgroundColor.2)
            
        }
        
        
        
        // 4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 5.滚动条位置发生改变
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.center.x = currentLabel.center.x
        })
        
        let moveTotalX = currentLabel.center.x - oldLabel.center.x
        
        if moveTotalX >= 0 {
            
            if (currentLabel.frame.origin.x + currentLabel.bounds.size.width) > (self.scrollView.contentOffset.x + UIScreen.main.bounds.size.width) {
                // 2.滚动正确的位置
                let offsetX = currentLabel.frame.origin.x + currentLabel.bounds.size.width - UIScreen.main.bounds.size.width + 30
                self.scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
                
            }
            
        }else {
            if currentIndex == 0 {
                
                self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                
            }else {
                
                if currentLabel.frame.origin.x < self.scrollView.contentOffset.x {
                    // 2.滚动正确的位置
                    let offsetX = currentLabel.frame.origin.x - 10
                    self.scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
                    
                }
            }
        }
        
        delegate?.classTitleView(self, selectedIndex: currentIndex)
    }
}

// MARK:- 对外暴露的方法
extension GDPageTitleView {
    @objc public func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
        let maxScale = 1 + scale
        
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.center.x - sourceLabel.center.x
        let moveX = moveTotalX * progress
        scrollLine.center.x = sourceLabel.center.x + moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (self.titleSelectColor.0 - self.titleNormalColor.0, self.titleSelectColor.1 - self.titleNormalColor.1, self.titleSelectColor.2 - self.titleNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: self.titleSelectColor.0 - colorDelta.0 * progress, g: self.titleSelectColor.1 - colorDelta.1 * progress, b: self.titleSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: self.titleNormalColor.0 + colorDelta.0 * progress, g: self.titleNormalColor.1 + colorDelta.1 * progress, b: self.titleNormalColor.2 + colorDelta.2 * progress)
        
        
        //背景颜色渐变
        let backColorDelta = (self.selectBackgroundColor.0 - self.normalBackgroundColor.0, self.selectBackgroundColor.1 - self.normalBackgroundColor.1, self.selectBackgroundColor.2 - self.normalBackgroundColor.2)
        sourceLabel.backgroundColor = UIColor(r: self.selectBackgroundColor.0 - backColorDelta.0 * progress, g: self.selectBackgroundColor.1 - backColorDelta.1 * progress, b: self.selectBackgroundColor.2 - backColorDelta.2 * progress)
        targetLabel.backgroundColor = UIColor(r: self.normalBackgroundColor.0 + backColorDelta.0 * progress, g: self.normalBackgroundColor.1 + backColorDelta.1 * progress, b: self.normalBackgroundColor.2 + backColorDelta.2 * progress)
        
        
        
        // sourceLabel缩放
        sourceLabel.transform = CGAffineTransform(scaleX: maxScale - scale * progress, y:maxScale - scale * progress)
        
        // targetLabel缩放
        targetLabel.transform = CGAffineTransform(scaleX: 1 + scale * progress, y:1 + scale * progress)
        
        if progress == 1.0 {
            // 4.记录最新的index
            currentIndex = targetIndex
            delegate?.classTitleViewCurrentIndex(self, currentIndex: currentIndex)
            
            if moveTotalX >= 0 {
                
                if (targetLabel.frame.origin.x + targetLabel.bounds.size.width) > (self.scrollView.contentOffset.x + UIScreen.main.bounds.size.width) {
                    // 2.滚动正确的位置
                    let offsetX = targetLabel.frame.origin.x + targetLabel.bounds.size.width - UIScreen.main.bounds.size.width + 30
                    self.scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
                    
                }
                
            }else {
                if currentIndex == 0 {
                    
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                    
                }else {
                    
                    if targetLabel.frame.origin.x < self.scrollView.contentOffset.x {
                        // 2.滚动正确的位置
                        let offsetX = targetLabel.frame.origin.x - 10
                        self.scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
                        
                    }
                }
            }
        }
    }
    
}

