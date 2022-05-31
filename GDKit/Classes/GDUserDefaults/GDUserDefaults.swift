//
//  GDUserDefaults.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

open class GDUserDefaults {
    
    private static let instance = GDUserDefaults()
    static let sharedInstance: GDUserDefaults = {
        
        return instance
    }()
    
    
    ///token
    public class func setToken(_ token: String? ) {
        UserDefaults.standard.set(token ?? "", forKey: "GDToken")
        UserDefaults.standard.synchronize()
        HttpProxy.shared.headers["Authorization"] = token ?? ""
    }
    
    public class func getToken() -> String? {
        let token = UserDefaults.standard.object(forKey: "GDToken") as? String
        return token
    }
    
    
    /**
     清除缓存
     */
    func clearCache(filePath:String) {
        
        ///读取文件路径
        let documnetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path:String = URL(fileURLWithPath: documnetPath).appendingPathComponent(filePath).absoluteString
        //存在就删除
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                printLog("出错了！")
            }
        }
    }
    
    
}


protocol UserDefaultsSettable {
    
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue == String {
    
    static func set(value: String?, forKey key: defaultKeys) {
        
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    
    static func string(forKey key: defaultKeys) -> String? {
        
        let aKey = key.rawValue
        return UserDefaults.standard.string(forKey: aKey)
    }
    
    static func setForDic(dict: Dictionary<String, Any>?, forKey key: defaultKeys) {
        
        let aKey = key.rawValue
        UserDefaults.standard.set(dict, forKey: aKey)
    }
    
    static func getDic(forKey key: defaultKeys) -> Dictionary<String,Any>? {
        let aKey = key.rawValue
        let dictionary = UserDefaults.standard.dictionary(forKey: aKey)
        return dictionary
    }
    
    static func setForData(data: Data?, forKey key: defaultKeys) {
        
        let aKey = key.rawValue
        UserDefaults.standard.set(data, forKey: aKey)
    }
    
    static func getData(forKey key: defaultKeys) -> Data? {
        let aKey = key.rawValue
        let array = UserDefaults.standard.data(forKey: aKey)
        return array
    }
    
}

extension NSObject {
    
    ///读取文件路径
    func getFilePath(fileName: String) -> String? {
        let documnetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return URL(fileURLWithPath: documnetPath).appendingPathComponent(fileName).absoluteString
    }
    

}
