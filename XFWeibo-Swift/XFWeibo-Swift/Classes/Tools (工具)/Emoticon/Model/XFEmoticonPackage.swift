//
//  XFEmoticonPackage.swift
//  表情键盘
//
//  Created by xiaofans on 16/8/13.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFEmoticonPackage: NSObject {
    
    var emoticons : [XFEmoticon] = [XFEmoticon]()
    
    init(id : String) {
        super.init()
        
        // 最近
        if id == "" {
            addEmptyEmoticon(true)
            return
        }
        
        // 根据id拼接info.plist的路径
        let plistPath = NSBundle.mainBundle().pathForResource("\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        
        // 根据文件路获取数据
        let array = NSArray(contentsOfFile: plistPath)! as! [[String : String]]
        
        // 遍历数据
        var index = 0
        for var dict in array {
            if let png = dict["png"] {
                dict["png"] = id + "/" + png
            }
            
            emoticons.append(XFEmoticon(dict: dict))
            
            index++
            
            if index == 20 {
                // 添加删除表情
                emoticons.append(XFEmoticon(isRemove: true))
                
                index = 0
            }
        }
        
        // 添加空白表情(占位用)
        addEmptyEmoticon(false)
    }
    
    /// 是否添加空白表情
    private func addEmptyEmoticon(isRecectly : Bool) {
        let count = emoticons.count % 21
        if count == 0 && !isRecectly {
            return
        }
        // 添加空白按钮
        for _ in count..<20 {
            emoticons.append(XFEmoticon(isEmpty: true))
        }
        // 添加删除按钮
        emoticons.append(XFEmoticon(isRemove: true))
    }

}

















