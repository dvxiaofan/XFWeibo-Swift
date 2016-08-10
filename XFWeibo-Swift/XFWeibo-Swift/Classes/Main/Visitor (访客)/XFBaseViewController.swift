//
//  XFBaseViewController.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/6.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFBaseViewController: UITableViewController {
    
    // MARK:- 懒加载
    lazy var visitorView : XFVisitorView = XFVisitorView.vistitorView()
    
    // MARK:- 定义变量
    var isLogin : Bool = XFUserAccountTool.shareInstance.isLogin

    // MARK:- 系统回调方法
    
    override func loadView() {
        
        // 判断是否还在访客视图
        isLogin ? super.loadView() : setupVistorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏
        setupNavItem()
    }
}

// MARK: - 设置界面
extension XFBaseViewController {
    /// 设置访客视图
    private func setupVistorView() {
        view = visitorView
        
        // 注册访客界面注册和登录按钮的监听
        visitorView.registerBtn.addTarget(self, action: "registerBtnClick", forControlEvents: .TouchUpInside)
        visitorView.loginBtn.addTarget(self, action: "loginBtnClick", forControlEvents: .TouchUpInside)
    }
    
    /// 设置导航栏左右按钮
    private func setupNavItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "registerBtnClick");
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "loginBtnClick")
    }
    
}

// MARK:- 事件监听
extension XFBaseViewController {
    /// 注册按钮
    @objc private func registerBtnClick() {
        XFLog("register")
    }
    
    /// 登录按钮
    @objc private func loginBtnClick() {
        let oauthVc = XFOAuthViewController()
        
        let oauthNav = UINavigationController(rootViewController: oauthVc)
        
        presentViewController(oauthNav, animated: true, completion: nil)
    }
}












