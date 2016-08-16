//
//  XFEmoticon.swift
//  表情键盘
//
//  Created by xiaofans on 16/8/13.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFEmoticon: NSObject {
    // MARK:- 定义属性
    var code : String? { // emoji 表情
        didSet {
            guard let code = code else {
                return
            }
            
            // 1. 创建一个表情扫描器
            let scahner = NSScanner(string: code)
            
            // 2. 调用方法, 扫描 code 中的值, 并通过地址给值赋值
            var value : UInt32 = 0
            scahner.scanHexInt(&value)
            
            // 3. 将 value 转成字符
            let c = Character(UnicodeScalar(value))
            
            // 4. 将字符专程字符串  就可以正常显示 emoji 表情了
            emojiCode = String(c)
        }
    }
    var png : String? { // 普通表情对应的图片名称
        didSet {
            guard let png = png else {
                return
            }
            
            pngPath = NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + png
        }
    }
    var chs : String?   // 普通表情对应的文字
    
    // MARK:- 数据处理
    var pngPath : String?
    var emojiCode : String?
    var isRemove : Bool = false
    var isEmpty : Bool = false
    
    // MARK:- 自定义构造函数
    init(dict : [String : String]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    init(isRemove : Bool) {
        self.isRemove = isRemove
        
    }
    
    init(isEmpty : Bool) {
        self.isEmpty = isEmpty
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description : String {
        return dictionaryWithValuesForKeys(["emojiCode", "pngPath", "chs"]).description
    }
}














