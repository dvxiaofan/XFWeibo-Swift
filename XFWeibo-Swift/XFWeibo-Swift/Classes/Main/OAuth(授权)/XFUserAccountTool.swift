//
//  XFUserAccountTool.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/10.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFUserAccountTool {
    
    // MARK:- 单例类
    static let shareInstance : XFUserAccountTool = XFUserAccountTool()
    
    // MARK:- 属性
    var account : XFUserAccount?
    
    // MARK:- 计算属性
    var accountPath : String {
        // 从沙盒中读取归档信息
        let accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        
        return (accountPath as NSString).stringByAppendingPathComponent("user.plist")
    }
    
    var isLogin : Bool {
        if account == nil {
            return false
        }
        
        guard let expires_date = account?.expires_date else {
            return false
        }
        
        return expires_date.compare(NSDate()) == NSComparisonResult.OrderedDescending
    }
    
    // MARK:- 重写 init() 方法
    init() {
        // 读取信息
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? XFUserAccount
    }
}

















