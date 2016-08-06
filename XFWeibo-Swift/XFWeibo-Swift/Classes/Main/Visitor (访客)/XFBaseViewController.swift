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
    var isLogin : Bool = false

    // MARK:- 系统回调方法
    
    override func loadView() {
        isLogin ? super.loadView() : setupVistorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

extension XFBaseViewController {
    /// 设置访客视图
    private func setupVistorView() {
        view = visitorView
    }
}














