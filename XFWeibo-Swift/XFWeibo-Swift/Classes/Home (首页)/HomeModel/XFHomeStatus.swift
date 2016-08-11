//
//  XFHomeStatus.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/11.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFHomeStatus: NSObject {
    
    // MARK:- 属性
    var created_at : String?            // 创建时间
    var source : String?                // 来源
    var text : String?                  // 内容正文
    var mid : Int = 0                   // id
    var user : XFUser?                  // 用户数据模型
    
    
    // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
        // 将用户字典专程用户模型
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = XFUser(dict: userDict)
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

}















