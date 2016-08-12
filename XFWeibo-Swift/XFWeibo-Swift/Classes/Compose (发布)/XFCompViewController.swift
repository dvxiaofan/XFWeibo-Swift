//
//  XFCompViewController.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/12.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFCompViewController: UIViewController {
    // MARK:- 懒加载
    private lazy var titleView : XFCompTitleView = XFCompTitleView()

    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏
        setupNavBar()
        
        
    }
}

// MARK:- 设置界面
extension XFCompViewController {
    /// 设置导航栏
    private func setupNavBar() {
        UINavigationBar.appearance().tintColor = UIColor.blackColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "backClick")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .Plain, target: self, action: "sendClick")
        navigationItem.rightBarButtonItem?.enabled = false
        
        navigationItem.titleView = titleView
        titleView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
    }
    
}

// MARK:- 事件监听
extension XFCompViewController {
    /// 返回按钮点击事件
    @objc private func backClick() {
         dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func sendClick() {
        XFLog("发送按钮")
    }
    
    
}














