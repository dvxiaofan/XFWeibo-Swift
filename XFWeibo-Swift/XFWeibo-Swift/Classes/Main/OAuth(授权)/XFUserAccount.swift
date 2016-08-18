//
//  XFUserAccount.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/10.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFUserAccount: NSObject, NSCoding {
    
    // MARK:- 属性
    var access_token : String?
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
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description : String {
        return dictionaryWithValuesForKeys(["access_token", "expires_date", "uid"]).description
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
    }
    
    required init?(coder aDecoder: NSCoder) {
        uid = aDecoder.decodeObjectForKey("uid") as? String
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
    }
}
















