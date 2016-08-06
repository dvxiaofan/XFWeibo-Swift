//
//  XFMainViewController.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFMainViewController: UITabBarController {
    
    // MARK:- 懒加载
    private lazy var composeBtn : UIButton = UIButton()
    
    // MARK:- 系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComposeBtn()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    

}

// MARK: - 设置界面
extension XFMainViewController {
    /// 设置发布按钮
    private func setupComposeBtn() {
        tabBar.addSubview(composeBtn)
        
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        
        composeBtn.sizeToFit()
        
        composeBtn.center = CGPointMake(tabBar.center.x, tabBar.bounds.size.height * 0.5)
    }
}


















