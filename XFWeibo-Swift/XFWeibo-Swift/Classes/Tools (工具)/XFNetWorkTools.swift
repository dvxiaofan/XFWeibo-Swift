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
        tools.responseSerializer.acceptableContentTypes?.insert("application/json")
        
        return tools
    }()
    
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
            XFLog("请求数据失败: \(error)")
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
            if error != nil {
                XFLog("请求AccessToken失败: \(error)")
            }
        }
        
    }
}

// MARK:- 请求用户数据
extension XFNetWorkTools {
    func loadUserInfo(access_token : String, uid : String, finished : (result : [String : AnyObject]?, error : NSError?) -> ()) {
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let parameters = ["access_token" : access_token, "uid" : uid]
        
        requestData(methodType: .GET, urlString: urlString, parameters: parameters) { (result, error) -> () in
            finished(result: result as? [String : AnyObject], error: error)
            if error != nil {
                XFLog("请求用户数据失败: \(error)")
            }
        }
    }
}

// MARK:- 请求主页数据
extension XFNetWorkTools {
    func loadHomeStatuses(since_id : Int, max_id : Int, finished : (result : [[String : AnyObject]]?, error : NSError?) -> ()) {
        //let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let urlString = "https://api.weibo.com/2/statuses/friends_timeline.json"
        let accessToken = (XFUserAccountTool.shareInstance.account?.access_token)!
        let parameters = ["access_token" : accessToken, "since_id" : "\(since_id)", "max_id" : "\(max_id)"]
        requestData(methodType: .GET, urlString: urlString, parameters: parameters) { (result, error) -> () in
            // 数据转字典
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                if error != nil {
                    XFLog("请求主页数据失败: \(error)")
                }
                return
            }
            // 将数组数据回调给外界
            finished(result: resultDict["statuses"] as? [[String : AnyObject]], error: error)
        }
    }
}

// MARK:- 发布无图片微博
extension XFNetWorkTools {
    func sendWeibo(statusText : String, isSuccess : (isSuccess : Bool) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        let accessToken = (XFUserAccountTool.shareInstance.account?.access_token)!
        let parameters = ["access_token" : accessToken, "status": statusText]
        
        requestData(methodType: .POST, urlString: urlString, parameters: parameters) { (result, error) -> () in
            if result != nil {
                isSuccess(isSuccess: true)
            } else {
                isSuccess(isSuccess: false)
                if error != nil {
                    XFLog("无图片的微博发送失败: \(error)")
                }
            }
        }
    }
}

// MARK:- 发送图片微博
extension XFNetWorkTools {
    func sendWeibo(statusText : String, image : UIImage, isSuccess : (isSuccess : Bool) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/upload.json"
        let accessToken = (XFUserAccountTool.shareInstance.account?.access_token)!
        let parameters = ["access_token" : accessToken, "status": statusText]
        
        POST(urlString, parameters: parameters, constructingBodyWithBlock: { (formatData) -> Void in
            if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                formatData.appendPartWithFileData(imageData, name: "pic", fileName: "000.png", mimeType: "image/png")
            }
            
            }, progress: nil, success: { (_, _) -> Void in
                isSuccess(isSuccess: true)
            }) { (_, error) -> Void in
                XFLog("图片微博发送失败: \(error)")
        }
    }
}

















