//
//  UITextView-Extension.swift
//  表情键盘
//
//  Created by xiaofans on 16/8/16.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

extension UITextView {
    /// 插入表情
    func insertEmoticon(emoticon : XFEmoticon) {
        // 1. 空白
        if emoticon.isEmpty {
            return
        }
        // 2. 删除按钮
        if emoticon.isRemove {
            deleteBackward()
            return
        }
        // 3. emoji 表情
        if emoticon.emojiCode != nil {
            // 获取光标所在位置
            let textRange = selectedTextRange!
            replaceRange(textRange, withText: emoticon.emojiCode!)
            return
        }
        // 4. 普通表情
        let attachment = XFEmoAttachment()
        attachment.chs = emoticon.chs
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        let font = self.font!
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attImageStr = NSAttributedString(attachment: attachment)
        // 创建可变属性字符串
        let attMuStr = NSMutableAttributedString(attributedString: attributedText)
        let range = selectedRange
        attMuStr.replaceCharactersInRange(range, withAttributedString: attImageStr)
        
        attributedText = attMuStr
        
        // 最后将文字大小重置
        self.font = font
        
        // 将光标设置回原来位置+1
        selectedRange = NSRange(location: range.location + 1, length: 0)
    }
    
    /// 获取对应表情字符串
    func getEmoticonString() -> String {
        // 获得可变数组字符串
        let attrMuStr = NSMutableAttributedString(attributedString: attributedText)
        
        // 遍历属性字符串
        let range = NSRange(location: 0, length: attrMuStr.length)
        attrMuStr.enumerateAttributesInRange(range, options: []) { (dict, range, _) -> Void in
            if let attachment = dict["NSAttachment"] as? XFEmoAttachment {
                attrMuStr.replaceCharactersInRange(range, withString: attachment.chs!)
            }
        }
        
        // 获取字符串
        return attrMuStr.string
    
    }
}























