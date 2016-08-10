//
//  AppDelegate.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // 根据是否登录判断默认 vc
    var defaultVc : UIViewController? {
        let isLogin = XFUserAccountTool.shareInstance.isLogin
        
        return isLogin ? XFWelcomeViewController() : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 设置全局 tabbar 颜色
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        
        // 创建 window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = defaultVc
        window?.makeKeyAndVisible()
        
        return true
    }
}













