//
//  XFNetWorkTools.swift
//  
//
//  Created by xiaofans on 16/8/10.
//  Copyright © 2016年 xiaofan. All rights reserved.
// 外部直接调用请求方法request
//

import AFNetworking


enum requestType : String {
    case GET = "GET"
    case POST = "POST"
}

class XFNetWorkTools: AFHTTPSessionManager {
    // MARK:- 单例
    // let 是线程安全的
    static let shareInstance : XFNetWorkTools = {
        let tools = XFNetWorkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    } ()
    
}

// MARK:- 封装请求方法
extension XFNetWorkTools {
    func requestData(methodType methodType : requestType, urlString : String, parameters : [String : AnyObject], finished : (result : AnyObject?, error : NSError?) -> ()) {
        
        // 1.定义成功的回调闭包
        let successCallBack = { (task : NSURLSessionDataTask, result : AnyObject?) -> Void in
            finished(result: result, error: nil)
        }
        
        // 2. 定义失败的回调闭包
        let failureCallBack = { (task : NSURLSessionDataTask?, error : NSError) -> Void in
            finished(result: nil, error: error)
        }
        
        // 3. 发送网络请求
        if methodType == .GET {
            GET(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        } else {
            POST(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    }
}

// MARK:- 请求 AccessToken 
extension XFNetWorkTools {
    func loadAccessToken(code : String, finished : (result : [String : AnyObject]?, error : NSError?) -> ()) {
        // url
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        // 参数
        let parameters = ["client_id" : app_Key, "client_secret" : app_Secret, "grant_type" :
            "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
        
        // 发送请求
        requestData(methodType: .POST, urlString: urlString, parameters: parameters) { (result, error) -> () in
            finished(result: result as? [String : AnyObject], error: error)
        }
        
    }
}
















