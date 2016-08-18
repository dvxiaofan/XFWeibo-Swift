//
//  XFComPopViewController.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/18.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFComPopViewController: UIViewController {
    
    // MARK:- 约束属性
    
    @IBOutlet weak var bottomCons: NSLayoutConstraint!

    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 改变约束值
    }
}

// MARK:- 事件监听
extension XFComPopViewController {
    
    @IBAction func wordBtnClick(sender: AnyObject) {
        
        let compVc = XFCompViewController()
        
        let nav = UINavigationController(rootViewController: compVc)
        
        presentViewController(nav, animated: true, completion: nil)
    }
    
    @IBAction func picBtnClick(sender: AnyObject) {
        XFLog("照片或者视频")
    }
    
    @IBAction func topBtnClick(sender: AnyObject) {
        XFLog("头条文章")
    }
    
    @IBAction func qianBtnClick(sender: AnyObject) {
        XFLog("签到")
    }
    
    @IBAction func showBtnClick(sender: AnyObject) {
        XFLog("直播")
    }
    
    @IBAction func moreBtnClick(sender: AnyObject) {
        XFLog("更多")
    }
    
    @IBAction func closeBtnClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}














