//
//  GDSelectImageView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit
import Photos
import TZImagePickerController
import MBProgressHUD

@objc protocol GDSelectImageViewDelegate {
    
    func gd_selectImageView(view:GDSelectImageView,imageArray:[Any])
}

class GDSelectImageView: UIView {
    
    // MARK: - constant 常量
    // 位置、大小、图片、文本
    
    /// 切割比例 默认自动缩放
    var scale: CGFloat = 2
    
    /// 是否用户编辑图片 默认 YES
    var isUserEdit: Bool = true
    
    /// 是否用户可以选择的数量
    var maxNum: Int = 1
    
    var keyVC:UIViewController?
    
    var allowPickingOriginalPhoto:Bool?
    var allowPickingVideo:Bool?
    weak var delegate: GDSelectImageViewDelegate?
    
    
    // MARK: - life cycle 生命周期
    //工程的viewDidLoad、viewWillAppear、init、didReceiveMemoryWarning等方法都放在这里
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        isUserEdit = true
        scale = 2
        maxNum = 1
        keyVC = UIApplication.shared.keyWindow!.rootViewController!
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - view layout 子视图的布局
    //界面布局
    
    
    // MARK: - event response 事件响应包括手势和按钮等
    //事件响应，包含手势、按钮、通知等等事件的处理
    
    func showView() {
        
        keyVC?.present(alertController, animated: true, completion: nil)
    }
    
    func clickPhotograph() {
        
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted) in
            
            if granted {
                DispatchQueue.main.async {
                    
                    let imagePicker:UIImagePickerController = UIImagePickerController.init()
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = self.isUserEdit
                    
                    self.keyVC?.present(imagePicker, animated: true, completion: nil)
                }
            }
            else {
                
                DispatchQueue.main.async {
                    MBProgressHUD.showText("使用拍照需要先开启相机权限哦~")
                    /*
                     GDMediator.sharedInstance().progressHUD_showAlertView(withTitle: "使用拍照需要先开启相机哦~", message: nil, cancelButtonTitle: "我再转转", otherButtonTitles: ["现在就去"], clickAtIndex: { (index) in
                     
                     if index == 2 {
                     self.pushSystemSet(isCamera: true)
                     }
                     })
                     */
                }
            }
        }
    }
    
    func clickAlbum() {
        PHPhotoLibrary.requestAuthorization { (status:PHAuthorizationStatus) in
            
            if status == PHAuthorizationStatus.authorized {
                
                DispatchQueue.main.async {
                    
                    let imagePicker = TZImagePickerController.init(maxImagesCount: self.maxNum, delegate: self)
                    imagePicker?.allowPickingVideo = self.allowPickingVideo ?? true
                    imagePicker?.allowPickingOriginalPhoto = self.allowPickingOriginalPhoto ?? true
                    
                    self.keyVC?.present(imagePicker!, animated: true, completion: nil)
                }
            }
            else {
                
                DispatchQueue.main.async {
                    MBProgressHUD.showText("使用相册需要先开启相册权限哦~")
                    /*
                     GDMediator.sharedInstance().progressHUD_showAlertView(withTitle: "使用相册需要先开启相册哦~", message: nil, cancelButtonTitle: "我再转转", otherButtonTitles: ["现在就去"], clickAtIndex: { (index) in
                     
                     if index == 2 {
                     self.pushSystemSet(isCamera: false)
                     }
                     })
                     */
                }
            }
        }
    }
    
    // MARK: - private method 业务无关的尽量弄成category，方便别人调用
    //没有暴露给外面调用的方法。
    
    func pushSystemSet(isCamera:Bool) {
        
        UIApplication.shared.openURL(URL.init(string: UIApplication.openSettingsURLString)!)
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
    
    lazy var alertController: UIAlertController = {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: { (action) in
            
            printLog("点击取消")
        }))
        
        alert.addAction(UIAlertAction.init(title: "拍照", style: UIAlertAction.Style.default, handler: { (action) in
            
            self.clickPhotograph()
            printLog("点击拍照")
        }))
        
        alert.addAction(UIAlertAction.init(title: "从手机相册选择", style: UIAlertAction.Style.default, handler: { (action) in
            self.clickAlbum()
            printLog("点击相册选择")
        }))
        return alert
    }()
    
}
// MARK: - delegate 具体到某个delegate，比如UITableViewDelegate
//代理或者数据源

extension GDSelectImageView: UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        var imagePickerc = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        var TW = imagePickerc.size.width
        var TH = imagePickerc.size.height
        
        if scale >= 1 {
            
            if TW > TH {
                
                if TW > 512 {
                    TH = 512 / TW * TH
                    TW = 512
                }
            }
            else {
                
                if TH > 512 {
                    
                    TW = 512 / TH * TW
                    TH = 512
                }
            }
        }
        else
        {
            TW *= scale
            TH *= scale
        }
        
        let rect = CGRect.init(x: 0, y: 0, width: TW, height: TH)
        //        UIGraphicsBeginImageContext(rect.size)
        /*
         * 参数一: 指定将来创建出来的bitmap的大小
         * 参数二: 设置透明YES代表透明，NO代表不透明
         * 参数三: 代表缩放,0代表不缩放
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        imagePickerc.draw(in: rect)
        imagePickerc = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        if self.delegate != nil {
            
            self.delegate?.gd_selectImageView(view: self, imageArray: [imagePickerc])
        }
    }
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        
        if self.delegate != nil {
            
            self.delegate?.gd_selectImageView(view: self, imageArray: photos)
        }
    }
}
