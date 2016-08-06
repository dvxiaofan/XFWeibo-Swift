//
//  XFMainViewController.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blueColor()
        
        // 获取 json 文件路径
        guard let jsonPath = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil) else {
            print("没有文件路径")
            return
        }
        
        // 读取文件信息
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {
            print("没有获取到数据")
            return
        }
        
        // 将二进制数据专程数组
        guard let anyObject = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) else {
            
            return
        }
        
        guard let dicArray = anyObject as? [[String : AnyObject]] else {
            
            return
        }
        
        // 遍历字典数组
        for dict in dicArray {
            // 获取控制器对应的字符串
            guard let vcName = dict["vcName"] as? String else {
                continue
            }
            
            // 获取控制器显示的 title
            guard let title = dict["title"] as? String else {
                continue
            }
            
            // 获取控制器显示的图标名字
            guard let imageName = dict["imageName"] as? String else {
                continue
            }
            
            // 添加子控制器
            addChildViewController(vcName, title: title, imageName: imageName)
            
        }
        
        
    }
    
    private func addChildViewController(childVCName: String, title : String, imageName : String) {
        
        // 获取命名空间
        guard let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有命名空间")
            return
        }
        
        // 根据字符串获得对应的 class 
        guard let childVCClass = NSClassFromString(nameSpace + "." + childVCName) else {
            print("没有获取到对应 class")
            return
        }
        
        // 将对应的 anyobject 转成控制器类型
        guard let childVCType = childVCClass as? UIViewController.Type else {
            print("没有对应控制器类型")
            return
        }
        
        // 创建对应控制器
        let childVC = childVCType.init()
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        let childNav = UINavigationController(rootViewController: childVC)
        
        addChildViewController(childNav)
    }
    

}



















