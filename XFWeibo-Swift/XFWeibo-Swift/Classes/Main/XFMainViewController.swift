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
        
        view.backgroundColor = UIColor.blueColor()
        
        addChildViewController(XFHomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(XFMsgViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(XFDisViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(XFProfileViewController(), title: "我", imageName: "tabbar_profile")



        
    }
    
    // Swift支持方法的重载: 方法名相同, 但参数不同 ---> 1. 参数的类型不同 2. 参数的个数不同
    // private 在当前文件中可以访问, 其他文件不能访问
    private func addChildViewController(childVC: UIViewController, title : String, imageName : String) {
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        let childNav = UINavigationController(rootViewController: childVC)
        
        addChildViewController(childNav)
    }
    

}



















