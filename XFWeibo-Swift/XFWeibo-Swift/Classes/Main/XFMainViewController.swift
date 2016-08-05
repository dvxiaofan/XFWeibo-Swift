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
        
        let childVC = XFHomeViewController()
        
        childVC.title = "首页"
        childVC.tabBarItem.image = UIImage(named: "tabbar_home")
        childVC.tabBarItem.selectedImage = UIImage(named: "tabbar_home_selected")
        
        let childNav = UINavigationController(rootViewController: childVC)
        
        addChildViewController(childNav)
        
    }

    

}
