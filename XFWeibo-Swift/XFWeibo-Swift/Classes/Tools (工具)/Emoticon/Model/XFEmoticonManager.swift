//
//  XFEmoticonManager.swift
//  表情键盘
//
//  Created by xiaofans on 16/8/13.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFEmoticonManager {
    
    var packages : [XFEmoticonPackage] = [XFEmoticonPackage]()
    
    init() {
        // 1. 添加最近表情
        packages.append(XFEmoticonPackage(id: ""))
        
        // 2.添加默认表情
        packages.append(XFEmoticonPackage(id: "com.sina.default"))
        
        // 3.添加emoji表情
        packages.append(XFEmoticonPackage(id: "com.apple.emoji"))
        
        // 4.添加浪小花表情
        packages.append(XFEmoticonPackage(id: "com.sina.lxh"))
        
    }
}
