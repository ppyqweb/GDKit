//
//  GDMoreImageSelectView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

@objc public protocol GDMoreImageSelectViewDelegate {
    
    func gd_moreImageSelectView(view:GDMoreImageSelectView, imageArray:[UIImage])
}

open class GDMoreImageSelectView: UIView {
    
    // MARK: - constant 常量
    // 位置、大小、图片、文本
    
    /// 图片数组
    public var imageMArray:Array = Array<UIImageView>()
    private var showImageMArray:Array = Array<UIImage>()
    
    public var isShowDelete: Bool = false
    
    /// 上下左右间隙
    public var edges:UIEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    
    /// 行距
    public var rowSpace:CGFloat = 5
    
    /// 列距
    public var columnSpace:CGFloat = 5
    
    /// 图片大小
    public var imageSize:CGSize = CGSize(width: 44, height: 44)
    
    /// 图片最大数量
    public var maxImageCount:Int = 6
    
    /// 当前点击的位置
    public var currentSelectIndex:Int = 0
    
    /// 最后一张是否选择图片
    public var isLastSelect:Bool = false
    
    public var addImage: String = ""
    
    public var isHiddenAddImage: Bool = false
    
    public weak var delegate: GDMoreImageSelectViewDelegate?
    
    
    public typealias swiftBlock = (CGFloat) -> ()
    public var heightBlock:swiftBlock?
    
    
    // MARK: - life cycle 生命周期
    //工程的viewDidLoad、viewWillAppear、init、didReceiveMemoryWarning等方法都放在这里
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - view layout 子视图的布局
    //界面布局
    
    func addImageView() -> UIImageView {
        
        let rect:CGRect = self.getAddImageViewFrame()
        let iconImageView = UIImageView(image: UIImage(named: self.addImage))
        iconImageView.frame = rect
        iconImageView.isUserInteractionEnabled = true
        let gestures = UITapGestureRecognizer.init(target: self, action: #selector(clickImageView(gestures:)))
        iconImageView.addGestureRecognizer(gestures)
        self.imageMArray.append(iconImageView)
        iconImageView.layer.cornerRadius = 7
        iconImageView.layer.masksToBounds = true
        self.hiddenAddImage()
        if isShowDelete == true {
            self.addDeleteBtn(iconImageView)
        }
        return iconImageView
    }
    
    func hiddenAddImage() {
        if self.isHiddenAddImage == false {
            return
        }
        for (i, imgView) in self.imageMArray.enumerated() {
            if i == self.imageMArray.count - 1,
                self.isLastSelect == false {
                imgView.isHidden = self.isHiddenAddImage
            } else {
                imgView.isHidden = false
            }
        }
    }
    
    func addDeleteBtn(_ imageView: UIImageView) {
        let width = 38.0.autoW
        let deleteBtn = UIButton(frame: CGRect(x: imageView.frame.size.width-width, y: 0, width: width, height: width))
        deleteBtn.setImage(UIImage(named: "delete_icon"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(onTouchDeleteBtnAction(_:)), for: .touchUpInside)
        imageView.addSubview(deleteBtn)
    }
    
    @objc func onTouchDeleteBtnAction(_ button: UIButton) {
        guard let imageView = button.superview as? UIImageView else {
            return
        }
        let index = self.getClickIndex(imageView: imageView)
        deleteImageView(index: index)
    }
    
    // MARK: - event response 事件响应包括手势和按钮等
    //事件响应，包含手势、按钮、通知等等事件的处理
    
    ///点击添加图片按钮
    public func clickImageView() {
        if self.isLastSelect == true {
            return
        }
        if let tap = self.imageMArray.last?.gestureRecognizers?.first as? UITapGestureRecognizer {
            self.clickImageView(gestures: tap)
        }
    }
    
    @objc func clickImageView(gestures: UITapGestureRecognizer) {
        UIApplication.shared.keyWindow?.endEditing(true)
        let imageView = gestures.view
        
        self.currentSelectIndex = self.getClickIndex(imageView: imageView as? UIImageView ?? UIImageView())
        if currentSelectIndex == imageMArray.count - 1 {
            /// 添加图片
            if isLastSelect {
                //最后一个按钮已经选择图片
                let mArray:Array = imageMArray
                browseImageView.showBrowseImageView()
                browseImageView.refreshUIImageView(array: mArray, index: currentSelectIndex)
            }
            else {
                
                selectImageView.showView()
            }
        }
        else {
            // 预览图片
            var mArray:Array = imageMArray
            if isLastSelect == false {
                
                mArray.removeLast()
            }
            browseImageView.showBrowseImageView()
            browseImageView.refreshUIImageView(array: mArray, index: currentSelectIndex)
        }
        
    }
    
    /// 删除浏览的图片
    ///
    /// - Parameter index: 图片位置
    func deleteImageView(index:Int) {
        
        if index < imageMArray.count {
            //删除index位置图片
            var imageView:Optional<UIImageView> = imageMArray[index]
            imageView?.removeFromSuperview()
            imageView = nil
            imageMArray.remove(at: index)
            if imageMArray.count < 1 {
                /// 已经无需要显示图片
                browseImageView.removeFromSuperview()
            }
            else {
                //位置全部重新刷新,优化点 只刷新后续部分，不会很多，故不做刷新
                
                for index in 0..<imageMArray.count {
                    
                    var point:CGPoint = CGPoint(x: 0, y: 0)
                    let curImageView:UIImageView = imageMArray[index]
                    if index == 0 {
                        
                        point = self.getNextImageViewPoint(nil)
                    }
                    else {
                        
                        let imageView:UIImageView = imageMArray[index - 1]
                        point = self.getNextImageViewPoint(imageView)
                    }
                    curImageView.left = point.x
                    curImageView.top =  point.y
                    
                }
                
                if isLastSelect == true {
                    /// 最后一张选择了图片,删除了一张图，需要重新把加号添加回来
                    self.addSubview(self.addImageView())
                    isLastSelect = false
                    self.hiddenAddImage()
                }
                
                var mArray:Array = imageMArray
                mArray.removeLast()
                currentSelectIndex = index < mArray.count ? index : mArray.count - 1
                //预览图片
                if currentSelectIndex < 0 {
                    
                    browseImageView.removeFromSuperview()
                }
                else {
                    
                    browseImageView.refreshUIImageView(array: mArray, index: currentSelectIndex)
                }
                
            }
            self.getSelfHeight()
            self.resultChange()
        }
    }
    
    // MARK: - private method 业务无关的尽量弄成category，方便别人调用
    //没有暴露给外面调用的方法。
    
    
    /// 获取添加图片按钮位置信息
    ///
    /// - Returns: 按钮位置坐标
    func getAddImageViewFrame() -> CGRect {
        
        let array = self.imageMArray
        let lastImageView = array.last
        let point = getNextImageViewPoint(lastImageView)
        
        return CGRect(x: point.x, y: point.y, width: self.imageSize.width, height: self.imageSize.height)
        
    }
    
    /// 获取当前点击的index
    ///
    /// - Parameter imageView:传入点击的图片
    /// - Returns: 返回点击位置
    func getClickIndex(imageView:UIImageView) -> Int {
        
        var index:Int = 0;
        for imageview in self.imageMArray {
            
            if imageview == imageView {
                
                break;
            }
            index += 1
        }
        return index;
    }
    
    /// 获取下一个图片的x,y
    ///
    /// - Parameter imageView: 图片
    /// - Returns: 返回坐标
    func getNextImageViewPoint(_ imageView: UIImageView?) -> CGPoint {
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        if let imageView = imageView {
            if imageView.right + columnSpace + imageSize.width + edges.right < width {
                //未超出最右边
                x = imageView.right + columnSpace
                y = imageView.top
            } else {
                x = edges.left
                y = imageView.bottom + rowSpace
            }
        } else {
            x = edges.left
            y = edges.top
        }
        
        return CGPoint(x: x, y: y)
    }
    
    
    /// 获取self的高度
    func getSelfHeight() {
        
        let lastImageView = self.imageMArray.last
        let totalHeight = (lastImageView?.bottom ?? 0) + self.edges.bottom
        if self.heightBlock != nil {
            
            heightBlock?(totalHeight)
        }
    }
    
    
    /// 多张图片显示
    ///
    /// - Parameter imageArray: 图片数组
    public func refreshUI(imageArray:Array<Any>) {
        
        self.isLastSelect = false
        if self.imageMArray.count <= 0 {
            self.addSubview(addImageView())
        }
        else {
            let first:Int = self.imageMArray.count - 1
            
            for index in first..<first+imageArray.count {
                
                if index < self.maxImageCount {
                    
                    let imageView:UIImageView = self.imageMArray[index]
                    let image:UIImage = imageArray[index - first] as? UIImage ?? UIImage()
                    
                    imageView.image = image
                    
                    if self.imageMArray.count < self.maxImageCount {
                        
                        self.addSubview(addImageView())
                    }
                    else {
                        self.isLastSelect = true
                        self.hiddenAddImage()
                    }
                }
                else {
                    
                    self.isLastSelect = true
                    self.hiddenAddImage()
                }
            }
            
        }
        getSelfHeight()
        resultChange()
    }
    
    /// 结果变化，删除，添加，一次性赋值,回调
    func resultChange() {
        
        var mArray:Array = [UIImage]()
        for (index,item) in imageMArray.enumerated() {
            printLog("下标：\(index) 值：\(item)")
            
            if !self.isLastSelect && index == self.imageMArray.count - 1 {
                continue
            }
            let imageview = self.imageMArray[index]
            mArray.append(imageview.image ?? UIImage())
        }
        
        if self.delegate != nil {
            
            delegate?.gd_moreImageSelectView(view: self, imageArray: mArray)
        }
    }
    
    // MARK: - push or pop 控制器
    //控制器跳转处理
    
    
    
    // MARK: - public method 公共方法
    //提供给对外调用的公共方法，一般来说，我的控制器是很少有提供给外界调用的方法，在viewmodel中有比较多的公共方法。
    
    
    
    // MARK: - request 请求信息
    //请求处理
    
    
    
    // MARK: - test 存放测试信息
    // 临时的测试信息，都放在这里，便于快速调试。
    
    
    
    // MARK: - getters and setters 构造器
    //get和set方法
    
    lazy var selectImageView: GDSelectImageView = {
        let imageView = GDSelectImageView.init(frame: CGRect.zero)
        imageView.delegate = self
        imageView.isUserEdit = false
        imageView.maxNum = self.maxImageCount
        return imageView
    }()
    
    public lazy var browseImageView: GDBrowseImageView = {
        let imageView = GDBrowseImageView.init(frame: CGRect.zero)
        imageView.deleteBlock = { (index:Int) in
            
            self.deleteImageView(index: index)
        }
        return imageView
    }()
    
}
// MARK: - delegate 具体到某个delegate，比如UITableViewDelegate
//代理或者数据源

extension GDMoreImageSelectView: GDSelectImageViewDelegate {
    
    func gd_selectImageView(view: GDSelectImageView, imageArray: [Any]) {
        
        refreshUI(imageArray: imageArray)
    }
}
