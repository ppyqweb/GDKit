//
//  UIImage+Extensions.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

extension UIImage {
    func compressImageOnlength(maxLength: Int) -> Data? {
        
        guard let vData = self.jpegData(compressionQuality: 1) else { return nil }
        if vData.count < maxLength {
            return vData
        }
        var compress:CGFloat = 0.9
        guard var data = self.jpegData(compressionQuality: compress) else { return nil }
        while data.count > maxLength && compress > 0.01 {
            compress -= 0.02
            data = self.jpegData(compressionQuality: compress)!
        }
        return data
    }
    

    //将图片裁剪成指定比例（多余部分自动删除）
    func crop(ratio: CGFloat) -> UIImage? {
        //计算最终尺寸
        var newSize:CGSize!
        if size.width/size.height > ratio {
            newSize = CGSize(width: size.height * ratio, height: size.height)
        }else{
            newSize = CGSize(width: size.width, height: size.width / ratio)
        }
     
        ////图片绘制区域
        var rect = CGRect.zero
        rect.size.width  = size.width
        rect.size.height = size.height
        rect.origin.x    = (newSize.width - size.width ) / 2.0
        rect.origin.y    = (newSize.height - size.height ) / 2.0
         
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        return scaledImage
    }
    
    /// CIImage转UIImage相对简单，直接使用UIImage的初始化方法即可
        func convertCIImageToUIImage(ciImage:CIImage) -> UIImage {
            let uiImage = UIImage.init(ciImage: ciImage)
            // 注意！！！这里的uiImage的uiImage.cgImage 是nil
            let cgImage = uiImage.cgImage
            // 注意！！！上面的cgImage是nil，原因如下，官方解释
            // returns underlying CGImageRef or nil if CIImage based
            return uiImage
        }
    // CGImage转UIImage相对简单，直接使用UIImage的初始化方法即可
    // 原理同上
        func convertCIImageToUIImage(cgImage:CGImage) -> UIImage {
            let uiImage = UIImage.init(cgImage: cgImage)
            // 注意！！！这里的uiImage的uiImage.ciImage 是nil
            let ciImage = uiImage.ciImage
            // 注意！！！上面的ciImage是nil，原因如下，官方解释
            // returns underlying CIImage or nil if CGImageRef based
            return uiImage
        }
        // MARK:- convert the CGImageToCIImage
        /// convertCGImageToCIImage
        ///
        /// - Parameter cgImage: input cgImage
        /// - Returns: output CIImage
        func convertCGImageToCIImage(cgImage:CGImage) -> CIImage{
            return CIImage.init(cgImage: cgImage)
        }

        // MARK:- convert the CIImageToCGImage
        /// convertCIImageToCGImage
        ///
        /// - Parameter ciImage: input ciImage
        /// - Returns: output CGImage
        func convertCIImageToCGImage(ciImage:CIImage) -> CGImage{


            let ciContext = CIContext.init()
            let cgImage:CGImage = ciContext.createCGImage(ciImage, from: ciImage.extent)!
            return cgImage
        }
    /// UIImage转为CIImage
    /// UIImage转CIImage有时候不能直接采用uiImage.ciImage获取
    /// 当uiImage.ciImage为nil的时候需要先通过uiImage.cgImage得到
    /// cgImage, 然后通过convertCGImageToCIImage将cgImage装换为ciImage
        func convertUIImageToCIImage(uiImage:UIImage) -> CIImage {

            var ciImage = uiImage.ciImage
            if ciImage == nil {
                let cgImage = uiImage.cgImage
                ciImage = self.convertCGImageToCIImage(cgImage: cgImage!)
            }
            return ciImage!
        }
    /// UIImage转为CGImage
    /// UIImage转CGImage有时候不能直接采用uiImage.cgImage获取
    /// 当uiImage.cgImage为nil的时候需要先通过uiImage.ciImage得到
    /// ciImage, 然后通过convertCIImageToCGImage将ciImage装换为cgImage
        func convertUIImageToCGImage(uiImage:UIImage) -> CGImage {
            var cgImage = uiImage.cgImage

            if cgImage == nil {
                let ciImage = uiImage.ciImage
                cgImage = self.convertCIImageToCGImage(ciImage: ciImage!)
            }
            return cgImage!
        }
}
