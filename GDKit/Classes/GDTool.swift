//
//  GDTool.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation


/// 打印
///
/// - Parameters:
///   - message: 打印内容
///   - file: 所在文件
///   - method: 所在方法
///   - line: 所在行
public func printLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    //    #if DEBUG
    //    print("\((file as NSString).lastPathComponent)[\(line)],\(method):\(message)")
    //    #endif
    print("\((file as NSString).lastPathComponent)[\(line)],\(method):\(message)")
}

public func callPhone(_ phoneStr: String) {
    // phoneStr:  电话号码
    let phone = "telprompt://" + phoneStr
    if UIApplication.shared.canOpenURL(URL(string: phone)!) {
         UIApplication.shared.openURL(URL(string: phone)!)
     }
}

public func phoneSecret(_ phoneStr: String?) -> String{
    if let phone = phoneStr, phone.count > 7 {
        let prePhone = phone.prefix(3)
        let subPhone = phone.suffix(4)
        return prePhone + "****" + subPhone
    }
    return phoneStr ?? ""
}
