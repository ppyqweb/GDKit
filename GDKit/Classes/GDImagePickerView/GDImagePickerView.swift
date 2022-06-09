//
//  GDImagePickerViewn.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit
import Kingfisher

public enum GDImagePickerViewType {
    case onlyShow           // 图片展示模式（不可添加和删除）
    case canDeleteButNoAdd  // 图片展示模式（不可添加但可以删除）
    case addAndDelete       // 图片编辑模式（可添加和删除）
}

open class GDImagePickerView: UIView {
    
    private static let cellWidth:CGFloat = 100.autoW
    //private static let cellWidth:CGFloat = k_ScreenWidth > 320 ? 70.0 : 60.0
    
    private static let cellTopInterval:CGFloat = 0.0
    private static let cellInterval:CGFloat = 8.0.autoH
    private static let cellSpace:CGFloat = 8.0.autoW
    internal var titleWidth:CGFloat = 0
    
    private var imageNameArray:Array<AnyHashable> = []
    private var imageViewFrameArray:[AnyHashable] = []
    private var imageViewArray:[AnyHashable] = []
    
    public var refreshThePickViewHeight: ((_ items:Array<GDImageOrVideoItem>, _ height:CGFloat)->())?
    var deleteAllMedias:(() -> ())?
    var deleteMediasAt:((_ index: Int) -> ())?
    
    private let reuseIdentifier = "GDImagePickerCell"
    
    /// 总个数
    var totalNum: Int = 0
    /// 是否可以编辑（删除）
    var canEdit = false
    /// 图片视频数组
    open var selectItemsInfo = [GDImageOrVideoItem]()
    
    var isRemoveFileWhenDelete = true
    public var pickerViewType: GDImagePickerViewType?       /// 选择的元素类型
    
    public var canPickSystemPhoto = false      /// 是否可以选择系统相册
    
    
    // MARK: - 1、生命周期函数
    
    public init(frame: CGRect, totalNum: Int) {
        self.totalNum = totalNum
        super.init(frame: frame)
        
        self.addSubview(pickerCollectionView)
        self.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 2、系统代理
    
    // MARK: - 3、自定义代理
    
    // MARK: - 4、相关响应事件
    
    @objc func tapProfileImage(gestureRecognizer: UITapGestureRecognizer?) {
        let tableGridImage = gestureRecognizer?.view
        guard let index: Int = tableGridImage?.tag else {
            return
        }
        
        guard let currentVC: UIViewController = self.getCurrentVC() else {
            return
        }
        guard let location:CGPoint = (gestureRecognizer?.location(in: currentVC.view)) else {
            return
        }
        guard let locationForView:CGPoint = (gestureRecognizer?.location(in: tableGridImage)) else {
            return
        }
        
        var frameArray:[AnyHashable] = []
        
        for i in 0..<self.imageViewFrameArray.count {
            var locationForX = 0
            var locationForY = 0
            
            var photoNumber = 3
            //var photoNumber = 4
            //var titleWidth = 0
            //var spaceWidth = 5
            
            if self.frame.width < k_ScreenWidth {
                photoNumber = 3
                //titleWidth = 80
                //spaceWidth = 0
            }
            
            if i < index {
                locationForY = Int(location.y - locationForView.y) - (index/photoNumber - i/photoNumber)*Int(GDImagePickerView.cellWidth) - (index/photoNumber - i/photoNumber)*Int(GDImagePickerView.cellInterval)
                
            }else if i == index{
                
                locationForY = Int(location.y - locationForView.y)
            }else{
                locationForY = Int(location.y - locationForView.y) + (i/photoNumber - index/photoNumber)*Int(GDImagePickerView.cellWidth) + (i/photoNumber - index/photoNumber)*Int(GDImagePickerView.cellInterval)
            }
            
            locationForX = Int(titleWidth) + (i%photoNumber)*Int(GDImagePickerView.cellWidth) + (i%photoNumber + 1)*Int(GDImagePickerView.cellSpace) + 5
            
            let originalFrame:CGRect = CGRect(x: locationForX, y: locationForY, width: Int(GDImagePickerView.cellWidth), height: Int(GDImagePickerView.cellWidth))
            let frameValue = NSValue(cgRect: originalFrame)
            
            frameArray.append(frameValue as AnyHashable)
        }
        
        if index == selectItemsInfo.count {
            addNewImageOrVideo()
        }else{
            // 查看预览图
            
            self.imageViewArray.removeAll()
            for i in 0..<selectItemsInfo.count {
                let selectItem:GDImageOrVideoItem = selectItemsInfo[i]
                let image:UIImage
                var imageView:UIImageView = UIImageView(image: UIImage(named: "default_photo_200_200"))
                if selectItem.imageUrl != nil {
                    if let selectItemImage = selectItem.image {
                        image = selectItemImage
                    }
                    imageView.kf.setImage(with: selectItem.imageUrl, placeholder: UIImage(named: "default_photo_200_200"))
                }else{
                    if let selectItemImage = selectItem.image {
                        
                        image = selectItemImage
                        imageView = UIImageView(image: image)
                    }
                }
                self.imageViewArray.append(imageView)
            }
            
            /*
             let imageNameArrayNS:NSArray = self.imageNameArray as NSArray
             let imageViewArrayNS:NSMutableArray = NSMutableArray(array: self.imageViewArray)
             let imageViewFrameArrayNS:NSMutableArray = NSMutableArray(array: frameArray)
             
             let photo = GDPhotoBrowserVC(imageNameArray: (imageNameArrayNS as? [Any])!, currentImageIndex: index!, imageViewArray: imageViewArrayNS, imageViewFrameArray: imageViewFrameArrayNS)
             
             let currentVC: UIViewController = self.getCurrentVC()!
             photo.modalPresentationStyle = .fullScreen
             currentVC.present(photo, animated: true) {
             }
             */
            
            if let imageViewArray = self.imageViewArray as? Array<UIImageView> {
                browseImageView.showBrowseImageView()
                browseImageView.refreshUIImageView(array: imageViewArray, index: index)
            }
            
        }
    }
    
    public lazy var browseImageView: GDBrowseImageView = {
        let imageView = GDBrowseImageView.init(frame: CGRect.zero)
        imageView.isShowDelete = false
        return imageView
    }()
    
    @objc func tapForPlayVideo(gestureRecognizer: UITapGestureRecognizer?) {
        let tableGridImage = gestureRecognizer?.view
        guard let index: Int = tableGridImage?.tag else {
            return
        }
        
        let selectItem:GDImageOrVideoItem = self.selectItemsInfo[index]
        guard let currentVC: UIViewController = self.getCurrentVC() else {
            return
        }
        guard let videoURL = (selectItem.videoNetURL == nil) ? selectItem.videoURL: selectItem.videoNetURL else {
            return
        }
        
        //定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.modalPresentationStyle = .fullScreen
        currentVC.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    
    // MARK: - 5、自定义函数
    
    func addNewImageOrVideo() {
        
        let takeType:String = "takePhoto"
        
        if canPickSystemPhoto && takeType != "takeVideo"{
            // 进去系统相册选择照片
            /*
             let vc = getCurrentVC()
             GDMediator.sharedInstance().progressHUD_showActionSheet(in: vc!.view, withTitle: "请选择图片来源", cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: ["拍照", "从相册选择"]) { (type) in
             if type == 2 {
             self.takePhotoOrVideo()
             }
             if type == 3 {
             let imagePickerVc = TZImagePickerController(maxImagesCount: 9 - (self.selectItemsInfo.count ), delegate: nil)
             imagePickerVc?.allowPickingVideo = false
             imagePickerVc?.allowPickingOriginalPhoto = false
             imagePickerVc?.allowTakePicture = false
             
             imagePickerVc?.didFinishPickingPhotosHandle = {[weak self] photos, assets, isSelectOriginalPhoto in
             for image in photos! {
             let imageItem = GDImageOrVideoItem(image: image, isRemoveFile: (self?.isRemoveFileWhenDelete)!)
             self?.selectItemsInfo.append(imageItem)
             if let imgCount = self?.selectItemsInfo.count {
             let _ = self?.changeCollectionViewHeight(itemsCount: imgCount)
             }
             self?.pickerCollectionView.reloadData()
             }
             //                        setTakePhotoVideoType(type:.image)
             
             }
             imagePickerVc?.modalPresentationStyle = .fullScreen
             vc?.present(imagePickerVc!, animated: true, completion: {
             
             })
             }
             }
             */
        }
        else {
            takePhotoOrVideo()
        }
    }
    
    func takePhotoOrVideo() {
        /*
         // 拍照或拍视频
         let takeType:String = "takePhoto"
         
         self.totalNum = 9
         
         if takeType.count == 0 {
         let vc = GDTakePhotoOrVideoVC()
         let currentVC: UIViewController = self.getCurrentVC()!
         vc.modalPresentationStyle = .fullScreen
         currentVC.present(vc, animated: true) {
         
         }
         vc.passonThePhotoImage = { image in
         //将选择的图片或者视频存入数组
         let imageItem = GDImageOrVideoItem(image: image, isRemoveFile: self.isRemoveFileWhenDelete)
         self.selectItemsInfo.append(imageItem)
         let _ = self.changeCollectionViewHeight(itemsCount: self.selectItemsInfo.count)
         self.pickerCollectionView.reloadData()
         }
         vc.passonTheVideoURL = { url in
         
         let videoItem = GDImageOrVideoItem(videoURL: url, isRemoveFile: self.isRemoveFileWhenDelete)
         self.selectItemsInfo.append(videoItem)
         
         self.totalNum = 3
         let _ = self.changeCollectionViewHeight(itemsCount: self.selectItemsInfo.count)
         self.pickerCollectionView.reloadData()
         }
         }else if takeType == "takePhoto" {
         let vc = GDOnlyTakePhotoVC()
         let currentVC: UIViewController = self.getCurrentVC()!
         vc.modalPresentationStyle = .fullScreen
         currentVC.present(vc, animated: true) {
         
         }
         vc.passonThePhotoImage = { image in
         //将选择的图片或者视频存入数组
         let imageItem = GDImageOrVideoItem(image: image, isRemoveFile: self.isRemoveFileWhenDelete)
         self.selectItemsInfo.append(imageItem)
         let _ = self.changeCollectionViewHeight(itemsCount: self.selectItemsInfo.count)
         self.pickerCollectionView.reloadData()
         }
         }else if takeType == "takeVideo" {
         let vc = GDOnlyTakeVideoVC()
         let currentVC: UIViewController = self.getCurrentVC()!
         vc.modalPresentationStyle = .fullScreen
         currentVC.present(vc, animated: true) {
         
         }
         vc.passonTheVideoURL = { url in
         
         let videoItem = GDImageOrVideoItem(videoURL: url, isRemoveFile: self.isRemoveFileWhenDelete)
         self.selectItemsInfo.append(videoItem)
         
         self.totalNum = 3
         let _ = self.changeCollectionViewHeight(itemsCount: self.selectItemsInfo.count)
         self.pickerCollectionView.reloadData()
         }
         }
         */
    }
    
    public func changeCollectionViewHeight(itemsCount:Int) -> CGFloat {
        
        var num:Int = Int(floor(self.width/(GDImagePickerView.cellWidth + GDImagePickerView.cellSpace)))
        // 每一行多少个图片
        if self.width > k_ScreenWidth {
            num = 3
            //num = k_ScreenWidth >= 320 ? 4:3
        }
        
        // 一共有多少行
        var heightNum = floor(Float(itemsCount)/Float(num))
        // 最多一共有多少行
        var maxHeightNum = ceilf(Float(totalNum)/Float(num))
        if pickerViewType == GDImagePickerViewType.onlyShow {
            maxHeightNum = ceilf(Float(itemsCount)/Float(num))
        }
        if heightNum == maxHeightNum {
            heightNum = maxHeightNum
        }else{
            heightNum = heightNum + 1
        }
        let height = CGFloat(heightNum)*GDImagePickerView.cellWidth + CGFloat((heightNum + 1))*GDImagePickerView.cellInterval + GDImagePickerView.cellTopInterval
        
        self.pickerCollectionView.height = height
        
        if itemsCount > 0 {
            self.refreshThePickViewHeight?(self.selectItemsInfo, height)
        }
        
        return height
    }
    
    
    public func refreshViewWithData(dataArray:Array<GDImageOrVideoItem>){
        self.selectItemsInfo = dataArray
        self.pickerCollectionView.reloadData()
        
        imageNameArray = []
        imageViewFrameArray = []
        imageViewArray = []
        
        if dataArray.count == 0 {
            self.pickerCollectionView.height = 90
        }
    }
    
    //* 根据图片再view中的位置，算出在window中的位置，并保存
    func saveWindowFrame(withOriginalFrame originalFrame: CGRect) {
        
        //因为数组不能存结构体，所以存的时候转成NSValue
        let frameValue = NSValue(cgRect: originalFrame)
        
        imageViewFrameArray.append(frameValue)
        imageViewFrameArray = imageNameArray.removingDuplicates()
    }
    
    // MARK: - 6、初始化
    lazy var pickerCollectionView:UICollectionView =  {
        
        var layout = UICollectionViewFlowLayout()
        var widthForCell = self.frame.size.width
        if self.frame.size.width < k_ScreenWidth {
            //            widthForCell = GDImagePickerView.cellWidth * 4 + GDImagePickerView.cellSpace * (4+1) + GDImagePickerView.cellSpace
            //            if k_ScreenWidth - 100 < widthForCell {
            //                widthForCell = GDImagePickerView.cellWidth * 3 + GDImagePickerView.cellSpace * (3+1) + GDImagePickerView.cellSpace
            //            }
        }else {
            //            widthForCell = GDImagePickerView.cellWidth * 4 + GDImagePickerView.cellSpace * (4+1) + GDImagePickerView.cellSpace
            widthForCell = k_ScreenWidth
        }
        var frame:CGRect = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: widthForCell, height: self.frame.size.height)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.isScrollEnabled = false
        collectionView.register(UINib(nibName: "GDImagePickerCell", bundle: Bundle(for: GDImagePickerCell.self)), forCellWithReuseIdentifier: reuseIdentifier)
        return collectionView
        
    }()
    
    var pcikType: GDImagePickerViewType? = GDImagePickerViewType.onlyShow {
        didSet {
            pickerViewType = pcikType
        }
    }
}

extension GDImagePickerView:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GDImagePickerCellDelegate{
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectItemsInfo.count >= totalNum {
            return selectItemsInfo.count
        }
        if pickerViewType == GDImagePickerViewType.onlyShow {
            return selectItemsInfo.count
        }
        return (selectItemsInfo.count ) + 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GDImagePickerCell ?? GDImagePickerCell()
        cell.delegate = self
        
        if (indexPath.row == selectItemsInfo.count) &&  selectItemsInfo.count < totalNum {
            cell.showImage.image = UIImage(named: "icon_camera")
            cell.deleBtn.isHidden = true
            cell.playVideoImage.isHidden = true
        }else{
            let selectItem:GDImageOrVideoItem = selectItemsInfo[indexPath.item]
            var image:UIImage?
            if selectItem.selectType == GDSelectItemType.selectImage{
                image = selectItem.image
                
                cell.playVideoImage.isHidden = true
            }else{
                if selectItem.videoNetURL != nil {
                    image = UIImage(named: "default_photo_200_200")
                }else{
                    image = self.thumbnailImage(forVideo: selectItem.videoURL)
                }
                cell.playVideoImage.isHidden = false
            }
            
            cell.deleBtn.isHidden = false
            if pickerViewType == GDImagePickerViewType.onlyShow{
                cell.deleBtn.isHidden = true
            }
            
            if image == nil {
                image = UIImage(named: "default_photo_200_200")
            }
            if selectItem.imageUrl != nil {
                cell.showImage.kf.setImage(with: selectItem.imageUrl)
                cell.showImage.kf.setImage(with: selectItem.imageUrl, placeholder: UIImage(named: "default_photo_200_200"))
            }else{
                cell.showImage.image = image
            }
            cell.deleBtn.tag = indexPath.item
            
            
            //用于图片预览
            if selectItem.selectType == GDSelectItemType.selectImage{
                
                let showImage:CGRect = (cell.convert((cell.frame), to:UIApplication.shared.delegate?.window!))
                saveWindowFrame(withOriginalFrame: (showImage))
                
                if selectItem.imageUrl == nil {
                    imageNameArray.append(indexPath.row)
                    imageNameArray =  imageNameArray.removingDuplicates()
                }else{
                    imageNameArray.append(selectItem.imageUrl)
                }
            }
            
            let _ = changeCollectionViewHeight(itemsCount: self.selectItemsInfo.count)
        }
        //添加图片cell点击事件
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.tapProfileImage(gestureRecognizer:)))
        singleTap.numberOfTapsRequired = 1
        cell.showImage.isUserInteractionEnabled = true
        cell.showImage.tag = indexPath.item
        cell.showImage.addGestureRecognizer(singleTap)
        
        // 添加播放视频点击事件
        let playvideoTap = UITapGestureRecognizer(target: self, action: #selector(self.tapForPlayVideo(gestureRecognizer:)))
        playvideoTap.numberOfTapsRequired = 1
        cell.playVideoImage.isUserInteractionEnabled = true
        cell.playVideoImage.tag = indexPath.item
        cell.playVideoImage.addGestureRecognizer(playvideoTap)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: GDImagePickerView.cellWidth, height: GDImagePickerView.cellWidth)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //return UIEdgeInsets(top: GDImagePickerView.cellTopInterval, left: GDImagePickerView.cellInterval, bottom: GDImagePickerView.cellInterval, right: GDImagePickerView.cellInterval)
        return UIEdgeInsets(top: GDImagePickerView.cellTopInterval, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return GDImagePickerView.cellInterval
    }
    
    // 两个cell之间的最小间距，是由API自动计算的，只有当间距小于该值时，cell会进行换行
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return GDImagePickerView.cellSpace
    }
    
    public func deleButtonClick(btn: Any) {
        let index:Int = (btn as AnyObject).tag
        self.selectItemsInfo.remove(at: index)
        self.imageNameArray.removeAll()
        self.imageViewFrameArray.removeAll()
        if self.deleteMediasAt != nil {
            self.deleteMediasAt?(index)
        }
        self.pickerCollectionView.reloadData()
        
        if selectItemsInfo.count == 0 {
            
            //            UserDefaults.takephotoOrVideoType.set(value: "", forKey: .takephotoOrVideoType)
            self.deleteAllMedias?()
        }
    }
}
