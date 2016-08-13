//
//  XFPicPickerCell.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/13.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFPicPickerCell: UICollectionViewCell {
    
    // MARK:- 拖线属性

    
    // MARK:- 事件监听
    @IBAction func addPicClick(sender: AnyObject) {
        // 发送添加照片通知
        NSNotificationCenter.defaultCenter().postNotificationName(XFPickerAddPhotoNote, object: nil)
    }
    
    @IBAction func deletedClick(sender: AnyObject) {
        XFLog("deleted")
    }
    

}
