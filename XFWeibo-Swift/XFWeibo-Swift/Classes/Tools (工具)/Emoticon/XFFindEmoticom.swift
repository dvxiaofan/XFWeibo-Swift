//
//  findEmoticom.swift
//  正则表达式
//
//  Created by xiaofans on 16/8/16.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFFindEmoticom: NSObject {
    
    // MARK:- 单例对象
    static let shareInstance : XFFindEmoticom = XFFindEmoticom()
    
    
    // MARK:- 表情属性
    private lazy var manager : XFEmoticonManager = XFEmoticonManager()
    
    // MARK:- 查找属性字符串
    func findAttrString(statusText : String?, font : UIFont) -> NSMutableAttributedString? {
        // 如果 statusText 没有值
        guard let statusText = statusText else {
            return nil
        }
        
        // 匹配规则
        let pattern = "\\[.*?\\]"
        
        // 正则表达式对象
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        
        //开始匹配
        let results = regex.matchesInString(statusText, options: [], range: NSRange(location: 0, length: statusText.characters.count))
        
        // 获得结果
        let attrMuString = NSMutableAttributedString(string: statusText)
        for var i = results.count - 1; i >= 0; i-- {
            let result = results[i]
            
            let chs = (statusText as NSString).substringWithRange(result.range)
            
            guard let pngPath = findPngPath(chs) else {
                return nil
            }
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(contentsOfFile: pngPath)
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attrImageStr = NSAttributedString(attachment: attachment)
            
            attrMuString.replaceCharactersInRange(result.range, withAttributedString: attrImageStr)
            
        }
        
        return attrMuString
    }
    
    private func findPngPath(chs : String) -> String? {
        for package in manager.packages {
            for emoticon in package.emoticons {
                if emoticon.chs == chs {
                    return emoticon.pngPath
                }
            }
        }
        return nil
    }
}
