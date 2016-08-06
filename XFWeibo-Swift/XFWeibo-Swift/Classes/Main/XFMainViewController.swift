//
//  XFMainViewController.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(XFHomeViewController())
        view.backgroundColor = UIColor.blueColor()
        
        addChildViewController("XFHomeViewController", title: "首页", imageName: "tabbar_home")
        addChildViewController("XFMsgViewController", title: "消息", imageName: "tabbar_message_center")
        addChildViewController("XFDisViewController", title: "发现", imageName: "tabbar_discover")
        addChildViewController("XFProfileViewController", title: "我", imageName: "tabbar_profile")
    }
    
    private func addChildViewController(childVCName: String, title : String, imageName : String) {
        
        // 获取命名空间
        guard let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有命名空间")
            return
        }
        
        // 根据字符串获得对应的 class 
        guard let childVCClass = NSClassFromString(nameSpace + "." + childVCName) else {
            print("没有获取到对应 class")
            return
        }
        
        // 将对应的 anyobject 转成控制器类型
        guard let childVCType = childVCClass as? UIViewController.Type else {
            print("没有对应控制器类型")
            return
        }
        
        // 创建对应控制器
        let childVC = childVCType.init()
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        let childNav = UINavigationController(rootViewController: childVC)
        
        addChildViewController(childNav)
    }
    

}



















