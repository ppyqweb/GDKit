//
//  Foundation+GDExtension.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

import AVFoundation
import MediaPlayer


extension String {
    
    /// MD5加密小写
//    var MD5String: String {
//        return self.md5().lowercased()
//    }
    
    //把常规字符串"like this" 转义成url编码的"like%20this"字符串:
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}

extension Int {
    //随机数生成
    static func random(in range: Range<Int>) -> Int {
        let count = UInt32(range.upperBound - range.lowerBound)
        return Int(arc4random_uniform(count)) + range.lowerBound
    }
}

extension NSObject {
    
    // MARK:返回className
    var className: String {
        get{
            let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[safe: 1];
            }else{
                return name;
            }
            
        }
    }
}

extension NSObject {
        
    /// 获取视频的某一帧图片
    func thumbnailImage(forVideo videoURL: URL?) -> UIImage? {
        guard let videoURL = videoURL else {
            return nil
        }
        if !(videoURL.isFileURL) {
            //默认封面图
            return UIImage(named: "default_photo_200_200")
        }
        let aset = AVURLAsset(url: videoURL, options: nil)
        let assetImg = AVAssetImageGenerator(asset: aset)
        assetImg.appliesPreferredTrackTransform = true
        assetImg.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels
        
        let timeScale: CMTimeScale = aset.duration.timescale //timescale为  fp
        do{
            let cgimgref = try assetImg.copyCGImage(at: CMTimeMake(value: 1, timescale: timeScale), actualTime: nil)
            return UIImage(cgImage: cgimgref)
        }catch{
            return UIImage(named: "default_photo_200_200")
        }
    }
    
    func getVideoFengMian(url:String) -> UIImage {
        
//        if url.isEmpty {
            //默认封面图
            return UIImage(named: "default_photo_200_200") ?? UIImage()
//        }

//        let pathStr = NSString(string:url)
//        let aset = AVURLAsset(url: URL(fileURLWithPath: GDKeyedUnarchiver().filePath(fileName:"videos/" + pathStr.lastPathComponent)), options: nil)
//        let assetImg = AVAssetImageGenerator(asset: aset)
//        assetImg.appliesPreferredTrackTransform = true
//        assetImg.apertureMode = AVAssetImageGeneratorApertureMode.encodedPixels
//        do{
//            let cgimgref = try assetImg.copyCGImage(at: CMTime(seconds: 10, preferredTimescale: 50), actualTime: nil)
//            return UIImage(cgImage: cgimgref)
//        }catch{
//            return UIImage(named: "default_photo_200_200")!
//        }
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
