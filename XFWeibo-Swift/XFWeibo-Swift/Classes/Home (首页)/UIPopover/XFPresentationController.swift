//
//  XFPresentationController.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/6.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit


class XFPresentationController: UIPresentationController {
    
    // MARK:- 懒加载
    private lazy var coverView : UIView = UIView()
    
    // MARK:- 系统回调方法
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        // 设置弹出视图的尺寸
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let width = screenWidth * 0.6
        let viewX = (screenWidth - width) * 0.5
        presentedView()?.frame = CGRect(x: viewX, y: 55, width: width, height: 300)
        
        // 设置弹出后的蒙版
        setupCoverView()
        
    }
}

// MARK:- 设置界面

extension XFPresentationController {
    private func setupCoverView() {
        // 添加蒙版 view
        containerView?.insertSubview(coverView, atIndex: 0)
        
        // 设置属性
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        
        // 设置 frame
        coverView.frame = containerView!.bounds
        
        // 添加手势识别
        let tapGes = UITapGestureRecognizer(target: self, action: "coverViewClick")
        coverView.addGestureRecognizer(tapGes)
    }
}

 // MARK:- 监听点击
extension XFPresentationController {
    @objc private func coverViewClick() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}











