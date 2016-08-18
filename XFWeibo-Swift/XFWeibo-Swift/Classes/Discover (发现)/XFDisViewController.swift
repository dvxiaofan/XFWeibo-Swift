//
//  XFDisViewController.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFDisViewController: XFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.setupVisitorViewInfo("visitordiscover_image_message", title: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
        
        setupNav()
    }
}

// MARK:- 设置导航栏
extension XFDisViewController {
    private func setupNav() {
        let isLogin = XFUserAccountTool.shareInstance.isLogin
        
        if isLogin {
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
        }
    }
}















