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
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var deletedBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK:- 定义属性
    var image : UIImage? {
        didSet {
            if image != nil {
                imageView.image = image
                addPhotoBtn.userInteractionEnabled = false
                deletedBtn.hidden = false
            } else {
                imageView.image = nil   // 防止循环引用
                addPhotoBtn.userInteractionEnabled = true
                deletedBtn.hidden = true
            }
        }
    }
    
    // MARK:- 事件监听
    @IBAction func addPicClick(sender: AnyObject) {
        // 发送添加照片通知
        NSNotificationCenter.defaultCenter().postNotificationName(XFPickerAddPhotoNote, object: nil)
    }
    
    @IBAction func deletedClick(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(XFPickerDeletedPhotoNote, object: imageView.image)
    }
}
