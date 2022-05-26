//
//  GDBrowseImageScrollView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

class GDBrowseImageScrollView: UIScrollView {
    
    // MARK: - constant 常量
    // 位置、大小、图片、文本
    //记录自己的位置
    var scaleOriginRect:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    //图片的大小
    var imgSize:CGSize = CGSize(width: 0, height: 0)
    
    //缩放前大小
    var initRect:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    typealias block = (_ scrollView:GDBrowseImageScrollView)->()
    var touchBlock:block?
    
    
    
    // MARK: - life cycle 生命周期
    //工程的viewDidLoad、viewWillAppear、init、didReceiveMemoryWarning等方法都放在这里
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.bouncesZoom = true
        self.backgroundColor = UIColor.black
        self.delegate = self
        self.minimumZoomScale = 1.0
        self.maximumZoomScale = 3.0
        
        self.addSubview(self.showImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - view layout 子视图的布局
    //界面布局
    
    
    
    // MARK: - event response 事件响应包括手势和按钮等
    //事件响应，包含手势、按钮、通知等等事件的处理
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touchBlock != nil {
            
            touchBlock!(self)
        }
    }
    
    // MARK: - private method 业务无关的尽量弄成category，方便别人调用
    //没有暴露给外面调用的方法。
    
    
    
    // MARK: - push or pop 控制器
    //控制器跳转处理
    
    
    
    // MARK: - public method 公共方法
    //提供给对外调用的公共方法，一般来说，我的控制器是很少有提供给外界调用的方法，在viewmodel中有比较多的公共方法。
    
    /// 内容宽度
    ///
    /// - Parameter rect: 大小
    func setContent(rect:CGRect) {
        
        showImageView.frame = rect
        initRect = rect
    }
    
    /// 设置动画时大小
    func setAnimationRect() {
        
        
        showImageView.frame = scaleOriginRect
        
    }
    
    /// 初始化
    func rechangeInitRdct() {
        
        self.zoomScale = 1.0;
        showImageView.frame = initRect
    }
    
    /// 设置当前图片
    ///
    /// - Parameter image: 图片
    func setupCurrentCImage(image:UIImage) {
        
        showImageView.image = image
        imgSize = image.size
        //判断首先缩放的值
        let scaleX:CGFloat = self.frame.size.width/imgSize.width
        let scaleY:CGFloat = self.frame.size.height/imgSize.height
        /// 倍数小的，先到边缘
        if scaleX > scaleY {
            /// Y方向先到边缘
            let imgViewWidth:CGFloat = imgSize.width*scaleY
            self.maximumZoomScale = self.frame.size.width/imgViewWidth
            scaleOriginRect = CGRect(x: self.frame.size.width/2-imgViewWidth/2, y: 0, width: imgViewWidth, height: self.frame.size.height)
        }
        else {
            /// X先到边缘
            let imgViewHeight:CGFloat = imgSize.height*scaleX
            self.maximumZoomScale = self.frame.size.height/imgViewHeight
            scaleOriginRect = CGRect(x: 0, y: self.frame.size.height/2-imgViewHeight/2, width: self.frame.size.width, height: imgViewHeight)
        }
        
        
    }
    // MARK: - request 请求信息
    //请求处理
    
    
    
    // MARK: - test 存放测试信息
    // 临时的测试信息，都放在这里，便于快速调试。
    
    
    
    // MARK: - getters and setters 构造器
    //get和set方法
    
    lazy var showImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.magnificationFilter = CALayerContentsFilter(rawValue: "nearest")
        return imageView
    }()
    
}
// MARK: - delegate 具体到某个delegate，比如UITableViewDelegate
//代理或者数据源

extension GDBrowseImageScrollView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return showImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        let boundsSize:CGSize = scrollView.bounds.size
        let imgFrame:CGRect = showImageView.frame
        let contentSize:CGSize = scrollView.contentSize
        var centerPoint:CGPoint = CGPoint(x: contentSize.width/2, y: contentSize.height/2)
        
        if imgFrame.size.width <= boundsSize.width {
            
            centerPoint.x = boundsSize.width / 2
        }
        if imgFrame.size.height <= boundsSize.height {
            
            centerPoint.y = boundsSize.height/2;
        }
        
        showImageView.center = centerPoint;
    }
}
