//
//  GDImageOrVideoItem.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

enum GDSelectItemType : Int {
    case selectImage = 2
    case selectVideo = 4
}

/// 媒体类型 1-文字, 2-图片, 3-声音, 4-视频, 5-链接, 99-其它’,
enum GDMediaType: Int  {
    case text   = 1
    case image  = 2
    case audio  = 3
    case video  = 4
    case link   = 5
    case other  = 99
}

/// 要上传的媒体参数
class GDMediaParameter: NSObject {
    // 媒体id
//    var id: Int = 0
    // 媒体类型
    var type: Int = 0
    // 媒体URL
    var url: String?
}

open class GDImageOrVideoItem: NSObject {

    var image: UIImage?         /// 选择的图片
    var imageFileName = ""      /// 图片文件名字
    var imageUrl: URL?          /// 图片链接 */
    var videoURL: URL?          /// 视频链接（本地）
    var videoNetURL: URL?       /// 视频链接（网络）
    var isComeFromNet = false   /// 是否是来源于网络
    var isComeFromCache = false /// 是否缓存文件
    var isRemoveFileWhenDelete = true  /// 删除时是否移除文件
    var selectType: GDSelectItemType?       /// 选择的元素类型
    var imagePath = ""          /// 图片路径
    var type = 1                /// 0.已经存在 1.需要缓存
    
    public init(imagePath: String?, isRemoveFile: Bool) {
        super.init()
        self.selectType = GDSelectItemType.selectImage
        guard let imagePath = imagePath else {
            return
        }
        image = UIImage(contentsOfFile: getFilePath(fileName: "images/\(String(describing: imagePath.last))") ?? "")
        imageFileName = "images/\(String(describing: imagePath.last))"
        isRemoveFileWhenDelete = isRemoveFile
    }
    
    public init(image: UIImage?, isRemoveFile: Bool) {
        super.init()
        self.image = image
        selectType = GDSelectItemType.selectImage
        isRemoveFileWhenDelete = isRemoveFile
    }
    
    public init(videoURL url: URL?, isRemoveFile: Bool) {
        super.init()

        selectType = GDSelectItemType.selectVideo
        videoURL = url
        isRemoveFileWhenDelete = isRemoveFile
    }
    
    public init(netImage url: URL?, isRemoveFile: Bool) {
        super.init()
        
        imageUrl = url
        isComeFromNet = true
        isComeFromCache = false
        selectType = GDSelectItemType.selectImage
        isRemoveFileWhenDelete = isRemoveFile
        DispatchQueue.global(qos: .default).async(execute: {
            var data: Data? = nil
            if let anUrl = url {
                data = try? Data(contentsOf: anUrl)
            }
            if let aData = data {
                self.image = UIImage(data: aData)
            }
        })
    }
    
    public init(netVideo url: URL?, isRemoveFile: Bool) {
        super.init()

        isComeFromNet = true
        isComeFromCache = false
        selectType = GDSelectItemType.selectVideo
        videoNetURL = url
        isRemoveFileWhenDelete = isRemoveFile
    }
    
    public init(cacheVideoURL url: URL?, isRemoveFile: Bool) {
        super.init()
        isComeFromNet = false
        isComeFromCache = true
        selectType = GDSelectItemType.selectVideo
        videoURL = getNewestURL(url: url)
        isRemoveFileWhenDelete = isRemoveFile
    }

    public init(image: UIImage?, isRemoveFile: Bool, imageFileName:String, imagePath:String) {
        super.init()
        self.image = image
        self.imageFileName = imageFileName
        self.imagePath = imagePath
        selectType = GDSelectItemType.selectImage
        isRemoveFileWhenDelete = isRemoveFile
    }
    
    public func getNewestURL(url: URL?) -> URL? {
        guard let path = getFilePath(fileName: "videos/\(String(describing: url?.path.last))") else {
            return nil
        }
        let newUrl = URL(fileURLWithPath: path)
        return newUrl
    }
}
