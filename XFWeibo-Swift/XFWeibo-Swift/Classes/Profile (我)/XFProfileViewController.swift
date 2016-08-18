//
//  XFProfileViewController.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFProfileViewController: XFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView.setupVisitorViewInfo("visitordiscover_image_profile", title: "登录后，你的个人微博、相册、个人资料会显示在这里，展示给别人")
        
        setupNav()
    }
}

// MARK:- 设置导航栏
extension XFProfileViewController {
    private func setupNav() {
        let isLogin = XFUserAccountTool.shareInstance.isLogin
        
        if isLogin {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "添加好友", target: self, action: "leftItemClick")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "设置", target: self, action: "rightItemClick")
        }
    }
}

// MARK:- 事件监听
extension XFProfileViewController {
    
    @objc private func leftItemClick() {
        XFLog("添加好友")
    }
    
    @objc private func rightItemClick() {
        XFLog("设置")
    }
}












