//
//  XFHomeViewController.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFHomeViewController: XFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 没有登录时需要设置的内容,增加动画
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        
        // 设置导航栏内容
        setupNavBar()
    }

}

// MARK:- 设置界面
extension XFHomeViewController {
    // MARK:- 设置导航栏
    private func setupNavBar() {
        // zuo
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch")
        
        // you
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        // titleview
    }
    
    
}

// MARK:- 事件监听
extension XFHomeViewController {
    // MARK:- 左按钮点击 
    
    // MARK:- 右按钮点击
    
    // MARK:- titleView 点击
    
    
}














