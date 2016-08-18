//
//  XFMsgViewController.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFMsgViewController: XFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.setupVisitorViewInfo("visitordiscover_image_message", title: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
        
        setupNav()
    }
}

// MARK:- 设置导航栏
extension XFMsgViewController {
    private func setupNav() {
        let isLogin = XFUserAccountTool.shareInstance.isLogin
        
        if isLogin {
            //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "发现群", style: .Plain, target: self, action: "leftItemClick")
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "发现群", target: self, action: "leftItemClick")
            navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: "rightItemClick")
        }
    }
}

// MARK:- 事件监听
extension XFMsgViewController {
    
    @objc private func leftItemClick() {
        XFLog("发现群")
    }
    
    @objc private func rightItemClick() {
        XFLog("发起聊天")
    }
}
















