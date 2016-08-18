//
//  XFMainViewController.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit
import BHBPopView

class XFMainViewController: UITabBarController {
    
    // MARK:- 懒加载
    private lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
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
        composeBtn.center = CGPointMake(tabBar.center.x, tabBar.bounds.size.height * 0.5)
        composeBtn.addTarget(self, action: "composeBtnClick", forControlEvents: .TouchUpInside)
    }
}

// MARK: - 事件监听
extension XFMainViewController {
    @objc private func composeBtnClick() {
        
        let basePath = "images.bundle/tabbar_compose_"
        
        let itemWord = BHBItem(title: "文字", icon: "\(basePath)idea")
        let itemPic = BHBItem(title: "照片/视频", icon: "\(basePath)photo")
        let itemTop = BHBItem(title: "头条文章", icon: "\(basePath)review")
        let itemqian = BHBItem(title: "签到", icon: "\(basePath)lbs")
        let itemShow = BHBItem(title: "直播", icon: "\(basePath)video")
        let itemMore = BHBItem(title: "更多", icon: "\(basePath)more")
        
        BHBPopView.showToView(self.view.window, withItems: [itemWord, itemPic, itemTop, itemqian, itemShow, itemMore]) { (item) -> Void in
            if item.title == itemWord.title {
                let compVc = XFCompViewController()
                let nav = UINavigationController(rootViewController: compVc)
                self.presentViewController(nav, animated: true, completion: nil)
            }
            XFLog(item.title)
        }
    }
}


















