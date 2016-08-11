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
    var created_at : String? {      // 创建时间
        didSet {
            guard let created_at = created_at else {
                return
            }
            
            // 对时间处理
            createdAtText = NSDate.createrDateString(created_at)
        }
    }
    var source : String? {          // 来源
        didSet {
            // 空值校验
            guard let source = source where source != "" else {
                return
            }
            
            // 对来源字符串进行处理
            let startIndex = (source as NSString).rangeOfString(">").location + 1
            let length = (source as NSString).rangeOfString("</").location - startIndex
            
            sourceText = (source as NSString).substringWithRange(NSRange(location: startIndex, length: length))
            
        }
    }
    var text : String?              // 内容正文
    var mid : Int = 0               // id
    
    // MARK:- 自定义数据处理属性
    var sourceText : String?        // 处理来源数据
    var createdAtText : String?    // 处理创建时间
    
    // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

}















