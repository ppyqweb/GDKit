//
//  UIImage+Extension.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

extension UIImage{
    
    /// 更改图片颜色
    public func changeColor(_ color : UIColor) -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        color.setFill()
        
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        UIRectFill(bounds)
        
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let image = tintedImage else {
            return UIImage()
        }
        
        return image
    }
    
    public class func setupQRCodeImage(_ text: String, image: UIImage?, _ color:UIColor? = nil) -> UIImage {
        //创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        //将url加入二维码
        filter?.setValue(text.data(using: String.Encoding.utf8), forKey: "inputMessage")
//        filter?.setValue(CIColor(cgColor: color?.cgColor ?? UIColor.orange.cgColor), forKey: "inputColor0")
//        filter?.setValue(CIColor(cgColor: UIColor.white.cgColor), forKey: "inputColor1")
        //取出生成的二维码（不清晰）
        if let outputImage = filter?.outputImage {
            
            let colorFilter = CIFilter(name: "CIFalseColor", parameters: ["inputImage":outputImage,"inputColor0":CIColor(cgColor: color?.cgColor ?? UIColor.orange.cgColor),"inputColor1":CIColor(cgColor: UIColor.white.cgColor)])
            
            //获取带颜色的二维码
            guard let newOutPutImage = colorFilter?.outputImage else {
                
                return UIImage()
            }
            
            //生成清晰度更好的二维码
            let qrCodeImage = setupHighDefinitionUIImage(newOutPutImage, size: 300)
            //如果有一个头像的话，将头像加入二维码中心
//            if var image = image {
//                //给头像加一个白色圆边（如果没有这个需求直接忽略）
//                image = circleImageWithImage(image, borderWidth: 30, borderColor: UIColor.clear)
//                //合成图片
//                let newImage = syntheticImage(qrCodeImage, iconImage: image, width: 200, height: 200)
//                return newImage
//            }
            return qrCodeImage
        }
        return UIImage()
    
    }
    
    //image: 二维码 iconImage:头像图片 width: 头像的宽 height: 头像的宽
    public class func syntheticImage(_ image: UIImage, iconImage:UIImage, width: CGFloat, height: CGFloat) -> UIImage{
        //开启图片上下文
        UIGraphicsBeginImageContext(image.size)
        //绘制背景图片
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
    
        let x = (image.size.width - width) * 0.5
        let y = (image.size.height - height) * 0.5
        iconImage.draw(in: CGRect(x: x, y: y, width: width, height: height))
        //取出绘制好的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        //返回合成好的图片
        if let newImage = newImage {
            return newImage
        }
        return UIImage()
    }
    
    //MARK: - 生成高清的UIImage
    public class func setupHighDefinitionUIImage(_ image: CIImage, size: CGFloat) -> UIImage {
        let integral: CGRect = image.extent.integral
        let proportion: CGFloat = min(size/integral.width, size/integral.height)
    
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
    
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
    
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion);
        bitmapRef.draw(bitmapImage, in: integral);
        let image: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: image)
    }
    
    
    
    ///生成二维码
    public class func generateQRCode(_ text: String,_ width:CGFloat,_ fillImage:UIImage? = nil, _ color:UIColor? = nil) -> UIImage? {
        
        //给滤镜设置内容
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            // 设置生成的二维码的容错率
            // value = @"L/M/Q/H"
            filter.setValue("H", forKey: "inputCorrectionLevel")
            
            //获取生成的二维码
            guard let outPutImage = filter.outputImage else {
                return nil
            }
            
            // 设置二维码颜色
            let colorFilter = CIFilter(name: "CIFalseColor", parameters: ["inputImage":outPutImage,"inputColor0":CIColor(cgColor: color?.cgColor ?? UIColor.black.cgColor),"inputColor1":CIColor(cgColor: UIColor.clear.cgColor)])
            
            //获取带颜色的二维码
            guard let newOutPutImage = colorFilter?.outputImage else {
                return nil
            }
//            if var image = fillImage {
//                //给头像加一个白色圆边（如果没有这个需求直接忽略）
//                image = circleImageWithImage(image, borderWidth: 30, borderColor: UIColor.clear)
//                //合成图片
//                let newImage = syntheticImage(qrCodeImage, iconImage: image, width: 200, height: 200)
//                return newImage
//            }
            
            let scale = width/newOutPutImage.extent.width
            
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            
            let output = newOutPutImage.transformed(by: transform)
            
            let QRCodeImage = UIImage(ciImage: output)
            
            guard let fillImage = fillImage else {
                return QRCodeImage
            }
            
            let imageSize = QRCodeImage.size
            
            UIGraphicsBeginImageContext(imageSize)
            
            QRCodeImage.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            
            let fillRect = CGRect(x: (width - width/5)/2, y: (width - width/5)/2, width: width/5, height: width/5)
            
            fillImage.draw(in: fillRect)
            
            guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return QRCodeImage }
            
            UIGraphicsEndImageContext()
            
            return newImage
            
        }
        
        return nil
        
    }
    
    
    ///生成条形码
    public class func generateCode128(_ text:String, _ size:CGSize,_ color:UIColor? = nil ) -> UIImage?
    {
        //给滤镜设置内容
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            
            filter.setDefaults()
            
            filter.setValue(data, forKey: "inputMessage")
            
            //获取生成的条形码
            guard let outPutImage = filter.outputImage else {
                return nil
            }
            
            // 设置条形码颜色
            let colorFilter = CIFilter(name: "CIFalseColor", parameters: ["inputImage":outPutImage,"inputColor0":CIColor(cgColor: color?.cgColor ?? UIColor.black.cgColor),"inputColor1":CIColor(cgColor: UIColor.clear.cgColor)])
            
            //获取带颜色的条形码
            guard let newOutPutImage = colorFilter?.outputImage else {
                return nil
            }
            
            let scaleX:CGFloat = size.width/newOutPutImage.extent.width
            
            let scaleY:CGFloat = size.height/newOutPutImage.extent.height
            
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
            let output = newOutPutImage.transformed(by: transform)
            
            let barCodeImage = UIImage(ciImage: output)
            
            return barCodeImage
            
        }
        
        return nil
    }
    
    
    func yl_scaleToSize(_ size:CGSize) -> UIImage {
    
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size);
        // 绘制改变大小的图片
        self.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        // 从当前context中创建一个改变大小后的图片
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return img;
    }
    
    //将图片缩放成指定尺寸（多余部分自动删除）
    func scaled(to newSize: CGSize) -> UIImage {
        //计算比例
        let aspectWidth  = newSize.width/size.width
        let aspectHeight = newSize.height/size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
         
        //图片绘制区域
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
         
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        return scaledImage!
    }
    
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
//        self.drawInRect(CGRectMake(0, 0, reSize.width, reSize.height))
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
}


