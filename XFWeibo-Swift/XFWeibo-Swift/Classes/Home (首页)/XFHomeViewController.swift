//
//  XFHomeViewController.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFHomeViewController: XFBaseViewController {
    
    
    // MARK:- 懒加载
    private lazy var titleBtn : XFTitleButton = XFTitleButton()
    
    private lazy var popAnimator : XFPopAnimator = XFPopAnimator {[weak self] (presented) -> () in
        
        self?.titleBtn.selected = presented
    }
    
    // MARK:- 系统回调方法
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
        titleBtn.setTitle("张小烦", forState: .Normal)
        titleBtn.addTarget(self, action: "titleBtnClick:", forControlEvents: .TouchUpInside)
        
        navigationItem.titleView = titleBtn
    }
    
    
}

// MARK:- 事件监听
extension XFHomeViewController {
    // MARK:- 左按钮点击 
    
    // MARK:- 右按钮点击
    
    // MARK:- titleView 点击
    @objc private func titleBtnClick(titleBtn : XFTitleButton) {
        
        // 1.创建弹出的控制器
        let popVc = XFPopViewController()
        
        // 2.保证弹出时下面的界面不会被移除
        popVc.modalPresentationStyle = .Custom
        
        // 3.设置专场代理
        popVc.transitioningDelegate = popAnimator
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let width = screenWidth * 0.6
        let viewX = (screenWidth - width) * 0.5
        popAnimator.presentedFrame = CGRect(x: viewX, y: 55, width: width, height: 300)
        
        // 4.弹出控制器
        presentViewController(popVc, animated: true, completion: nil)
    }
    
}

















