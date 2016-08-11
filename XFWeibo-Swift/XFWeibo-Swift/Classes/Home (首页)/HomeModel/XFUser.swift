//
//  XFUser.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/11.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFUser: NSObject {
    
    // MARK:- 属性
    var screen_name : String?           // 昵称
    var profile_image_url : String?     // 用户头像
    var verified_type : Int = -1        // 认证类型
    var mbrank : Int = 0                // 会员等级
    
    // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    // 默写键未用, 需要重写此方法, 否则会报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

}









