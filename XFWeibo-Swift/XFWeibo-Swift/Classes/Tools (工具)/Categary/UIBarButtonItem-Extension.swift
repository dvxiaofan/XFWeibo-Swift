//
//  UIBarButtonItem-Extension.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/6.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    convenience init (imageName : String) {
        self.init()
        
        let button = UIButton()
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        button.sizeToFit()
        
        self.customView = button
        
    }
}





