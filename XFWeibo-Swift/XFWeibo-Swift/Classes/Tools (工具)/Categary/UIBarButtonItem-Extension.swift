//
//  UIBarButtonItem-Extension.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/6.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    convenience init (imageName : String, target: AnyObject?, action: Selector) {
        self.init()
        
        let button = UIButton()
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        button.sizeToFit()
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        self.customView = button
        
    }
    
    /// 自定义 itemBtn
    convenience init(title : String, target: AnyObject?, action: Selector) {
        self.init()
        let button = UIButton()
        button.setTitle(title, forState: .Normal)
        button.sizeToFit()
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: .Highlighted)
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        self.customView = button
    }
}





