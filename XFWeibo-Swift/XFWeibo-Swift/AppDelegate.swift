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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.rootViewController = XFMainViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}














