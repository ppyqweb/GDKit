//
//  GDHttpProxy.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
import Accelerate

open class HttpProxy {
    public static let shared = HttpProxy()
    
    /// 成功
    public typealias OnSuccessBlock = (GDResultModel) -> Void
    /// 失败
    public typealias OnErrorBlock = (Error) -> Void
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json;charset=utf-8",
        "Accept": "application/json",
        //"Authorization": UserDefaults.standard.string(forKey: k_Sso_Token) ?? ""
    ]
    
    fileprivate let manager: Session = {
        // 配置的adapter 和 retrier
        //    config.adapter = AutoLogin()
        //    config.retrier = AutoLogin()
        let configuration = URLSessionConfiguration.default
        //请求超时时间15秒
        configuration.timeoutIntervalForRequest = 15
        return Alamofire.Session(configuration: configuration)
        
    }()
    
    public func post(url:String,parameters:Dictionary<String, Any>, success: @escaping OnSuccessBlock, failed: @escaping OnErrorBlock){
        
        //表单请求
        self.formDataRequest(method: .post, url: url, parameters: parameters, success: success, failed: failed)
        //json请求
        //self.request(method: .post, url: url, parameters: parameters, encoding: JSONEncoding.default, success: success, failed: failed)
    }
    
    public func get(url:String,parameters:Dictionary<String, Any>, success: @escaping OnSuccessBlock, failed: @escaping OnErrorBlock) {
        self.request(method: .get, url: url, parameters: parameters, encoding: URLEncoding.default, success: success, failed: failed)
    }
    
    func request(method: HTTPMethod, url:String,parameters:Dictionary<String, Any>, encoding: ParameterEncoding, success: @escaping OnSuccessBlock, failed: @escaping OnErrorBlock) {

        manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response) in
            self.dataProcess(response: response, parameters: parameters, success: success, failed: failed)
        }

    }
    
    ///表单请求
    func formDataRequest(method: HTTPMethod, url:String,parameters:Dictionary<String, Any>, success: @escaping OnSuccessBlock, failed: @escaping OnErrorBlock) {

        manager.upload(multipartFormData: { (mutilPartData) in
            ///添加表单 form-data到body
            for key in parameters.keys {
                let value = parameters[key] as! String
                let vData: Data = value.data(using: .utf8)!
                mutilPartData.append(vData, withName: key)
            }
        }, to: url, usingThreshold: UInt64.init(), method: method, headers: headers).responseJSON { (response) in
            self.dataProcess(response: response, parameters: parameters, success: success, failed: failed)
        }
    }
    
    func dataProcess(response: AFDataResponse<Any>, parameters:Dictionary<String, Any>, success: @escaping OnSuccessBlock, failed: @escaping OnErrorBlock) {
        printLog("请求头----> \(headers.description)")
        printLog("请求链接----> \(response.request as Any)")  // original URL request
        printLog("请求参数----> \(parameters)")
        var result: GDResultModel = GDResultModel()
        switch response.result {
        case .success:
            printLog("Validation Successful")
            if response.response != nil {
                
                self.decisionHttpStatusCode(statusCode: response.response?.statusCode)
                
                //                    if giga_session_id != nil {
                //                      UserDefaults.standard.set(giga_session_id, forKey: k_Giga_Session_Id)
                //                    }
                
            }
            if response.value != nil {
                
                if let value = response.value as? [String : Any]{
                    
                    result = GDResultModel.deserialize(from: value) ?? result
                    if value["type"] as? String ?? "" == "SUCCESS" {
                        result.type = .success
                    }
                }
                ///具体如何解析json内容可看下方“响应处理”部分
                printLog("返回数据---->  \(String(describing: response.value))")
            }
            if result.message.count == 0 {
                result.message = self.errorMsg(result.code)
            }
            success(result)
            
        case .failure(let error):
            printLog(error)
            failed(error)
        }
    
    }
    
    func errorMsg(_ code: Int) -> String {
        var msg = ""
        switch(code) {
        case 10000:
            msg = "操作成功"//SUCCESS
            break
            
        case 10001:
            msg = "数据校验成功"//SUCCESS
            break
            
        case 10002:
            msg = "接口开发中"//SUCCESS
            break
            
        case 99001:
            msg = "已执行操作，但在数据库操作没有返回成功结果"
            break
            
        case 99002:
            msg = "放置用户在线信息失败，用户已离线"
            break
            
        case 99003:
            msg = "用户登录状态已过期"
            break
            
        case 99004:
            msg = "用户未登录"
            break
            
        case 99005:
            msg = "发送短信时，API没有返回成功结果"
            break
            
        case 99006:
            msg = "验证码不存在"
            break
            
        case 99007:
            msg = "验证码已过期"
            break
            
        case 99008:
            msg = "验证码不匹配"
            break
            
        case 99998:
            msg = "操作失败，发生了异常"
            break
            
        case 99999:
            msg = "操作失败"
            break
        default:
            break
        }
        //TODO: - 测试
        return msg + String(code)
    }
    
    
    /// 判断状态码是否为401
    func decisionHttpStatusCode(statusCode:Int?) {
        switch(statusCode) {
        case 401,403:
            //            UserDefaults.standard.removeObject(forKey: k_Sso_Token)
            //            UserDefaults.standard.removeObject(forKey: k_Login_Data)
            //            UserDefaults.standard.removeObject(forKey: k_Login_Phone)
            //
            //            // 退出清除极光推送tag
            //            JPUSHService.cleanTags({ (iResCode, iTags, seq) in
            //            }, seq: 3)
            //            JPUSHService.deleteAlias({ (iResCode, iAlias, seq) in
            //            }, seq: 2)
            //
            //            JZY_NOTIFACTION_CENTER.post(name: NSNotification.Name(kAppDelegateNotifactionWillRootVCSwitch), object: self, userInfo: [:])
            break
        default:
            break
        }
        
    }
    
    
    
   
    
    
    
    
    
}

public enum GDResultType: String {
    case success = "SUCCESS"
    case failure = "FAIL"
}

public class GDResultModel: HandyJSON {
    //    var code:Int = -1
    //    var success:Bool = false
    //    var message:String = ""
    
    public var code: Int        = -1
    public var message: String  = ""
    public var data: Any?
    public var type: GDResultType     = .failure //"SUCCESS","FAIL"
    
    public required init() {}
}
