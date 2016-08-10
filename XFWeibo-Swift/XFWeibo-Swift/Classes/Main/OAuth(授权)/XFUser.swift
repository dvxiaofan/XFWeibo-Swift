//
//  XFUser.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/10.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFUser: NSObject {
    
    // MARK:- 属性
    /// 授权后的access_token
    var access_token : String?
    /// 过期时间 -- 秒
    var expires_in : NSTimeInterval = 0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    /// 用户 ID
    var uid : String?
    
    /// 过期时间
    var expires_date : NSDate?
    
    /// 昵称
    var screen_name : String?
    
    /// 头像
    var avatar_large : String?
    
    
    // MARK:- 自定义构造函数
    //override init() {}
    
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    // MARK:- description 重写, 自定打印对象时的内容
    override var description : String {
        return dictionaryWithValuesForKeys(["access_token", "expires_date", "uid"]).description
    }
    
    
}
















