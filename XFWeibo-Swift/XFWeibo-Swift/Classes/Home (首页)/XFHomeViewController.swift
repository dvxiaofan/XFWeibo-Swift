//
//  XFHomeViewController.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFHomeViewController: XFBaseViewController {
    
    // MARK:- 属性
    
    // MARK:- 懒加载
    private lazy var titleBtn : XFTitleButton = XFTitleButton()
    
    private lazy var popAnimator : XFPopAnimator = XFPopAnimator {[weak self] (presented) -> () in
        
        self?.titleBtn.selected = presented
    }
    // 模型数组
    private lazy var statuses : [XFHomeStatus] = [XFHomeStatus]()
    
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
        
        // 请求数据
        loadHomeStatuses()
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
        titleBtn.setTitle(XFUserAccountTool.shareInstance.account?.screen_name, forState: .Normal)
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
        let width = screenSize.width * 0.6
        let viewX = (screenSize.width - width) * 0.5
        popAnimator.presentedFrame = CGRect(x: viewX, y: 55, width: width, height: 300)
        
        // 4.弹出控制器
        presentViewController(popVc, animated: true, completion: nil)
    }
    
}

// MARK:- 请求数据
extension XFHomeViewController {
    private func loadHomeStatuses() {
        XFNetWorkTools.shareInstance.loadHomeStatuses { (result, error) -> () in
            // 错误校验
            if error != nil {
                XFLog(error)
                return
            }
            
            // 获取可选类型中的数组
            guard let resultArray = result else {
                return
            }
            
            // 遍历数组对应的字典
            for statusDict in resultArray {
                // 字典数据转模型
                let status = XFHomeStatus(dict: statusDict)
                self.statuses.append(status)
            }
            
            // 刷新表格
            self.tableView.reloadData()
        }
    }
}

// MARK:- tableview 数据源方法
extension XFHomeViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 创建 cell
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell")!
        
        // 设置数据
        let status = statuses[indexPath.row]
        cell.textLabel?.text = status.text
        
        return cell
    }
}


























