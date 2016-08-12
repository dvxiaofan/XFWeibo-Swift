//
//  XFHomeViewController.swift
//  XFWeibo-Swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class XFHomeViewController: XFBaseViewController {
    
    // MARK:- 属性
    
    // MARK:- 懒加载
    private lazy var titleBtn : XFTitleButton = XFTitleButton()
    
    private lazy var popAnimator : XFPopAnimator = XFPopAnimator {[weak self] (presented) -> () in
        
        self?.titleBtn.selected = presented
    }
    // 模型数组
    private lazy var viewModels : [XFStatusViewModel] = [XFStatusViewModel]()
    
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
        //loadHomeStatuses()
        
        // 设置估算高度
        tableView.estimatedRowHeight = 200
        
        // 设置下拉刷新
        setupHeaderView()
        
        // 设置上来加载更多
        setupFooterView()
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
    
    // MARK:- 设置 headerview
    private func setupHeaderView() {
        // 下拉刷新 headerview
        let headerView = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "loadNewStatuses")
        
        // 设置属性
        headerView.setTitle("下拉刷新", forState: .Idle)
        headerView.setTitle("释放更新", forState: .Pulling)
        headerView.setTitle("加载中...", forState: .Refreshing)
        headerView.lastUpdatedTimeLabel?.hidden = true
        
        // 设置 tableView 的 headerView
        tableView.mj_header = headerView
        
        // 进入刷新
        tableView.mj_header.beginRefreshing()
    }
    
    // MARK:- 设置 footerveiw
    private func setupFooterView() {
        let footerView = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: "loadMoreStatuses");
        footerView.setTitle("加载中...", forState: .Refreshing)
        footerView.automaticallyHidden = true
        
        tableView.mj_footer = footerView
        
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
    /// 加载最新数据
    @objc private func loadNewStatuses() {
        loadHomeStatuses(true)
    }
    
    // MARK:- 加载更多数据
    @objc private func loadMoreStatuses() {
        loadHomeStatuses(false)
    }
    
    /// 加载微博数据
    private func loadHomeStatuses(isNewData : Bool) {
        
        // 获取 since_id
        var since_id = 0
        var max_id = 0
        if isNewData {
            since_id = viewModels.first?.status?.mid ?? 0
        } else {
            max_id = viewModels.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        // 请求数据
        XFNetWorkTools.shareInstance.loadHomeStatuses(since_id, max_id: max_id) { (result, error) -> () in
            // 错误校验
            if error != nil {
                XFLog(error)
                return
            }
            
            // 获取可选类型中的数组
            guard let resultArray = result else {
                return
            }
            
            // 定义临时数组
            var tempViewModel = [XFStatusViewModel]()
            // 遍历数组对应的字典
            for statusDict in resultArray {
                // 字典数据转模型
                let status = XFHomeStatus(dict: statusDict)
                
                let viewModel = XFStatusViewModel(status: status)
                // 先将数据加入到临时数组中
                tempViewModel.append(viewModel)
            }
            
            // 将数据放入到成员变量数组中
            if isNewData {
                self.viewModels = tempViewModel + self.viewModels
            } else {
                self.viewModels += tempViewModel
            }
            
            // 缓存图片
            self.cacheImages(tempViewModel)
        }
    }
    
    // MARK:- 缓存图片
    private func cacheImages(viewModels : [XFStatusViewModel]) {
        // 创建多线程 group
        let group = dispatch_group_create()
        
        for viewModel in viewModels {
            for picURL in viewModel.picURLs {
                // 进入组
                dispatch_group_enter(group)
                
                SDWebImageManager.sharedManager().downloadImageWithURL(picURL, options: [], progress: nil, completed: { (_, _, _, _, _) -> Void in
                    // 离开组
                    dispatch_group_leave(group)
                })
            }
        }
        // 刷新表格
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
}

// MARK:- tableview 数据源方法
extension XFHomeViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 创建 cell
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as! XFHomeViewCell
        
        // 设置数据
        cell.viewModel = viewModels[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let viewModel = viewModels[indexPath.row]
        
        return viewModel.cellHeight
    }
}


























