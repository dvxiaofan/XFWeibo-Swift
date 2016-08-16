//
//  XFEmoticonController.swift
//  表情键盘
//
//  Created by xiaofans on 16/8/13.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit


private let XFEmoticonCellID = "XFEmoticonCellID"

class XFEmoticonController: UIViewController {
    
    // MARK:- 定义属性
    var emoticonCallBack : (emoticon : XFEmoticon) -> ()

    
    // MARK:- 懒加载
    private lazy var collectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: EmoticonCollectionViewLayout())
    private lazy var toolBar : UIToolbar = UIToolbar()
    private lazy var emoManager = XFEmoticonManager()
    
    // MARK:- 自定义构造函数
    init(emoticonCallBack : (emoticon : XFEmoticon) -> ()) {
        // 先赋个初始值
        self.emoticonCallBack = emoticonCallBack
        
        super.init(nibName: nil, bundle: nil)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

// MARK:- 设置 UI见面
extension XFEmoticonController {
    
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        collectionView.backgroundColor = UIColor.brownColor()
        toolBar.backgroundColor = UIColor.blueColor()
        
        // 设置 frame - 代码约束要设置下面为 false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["toolBar" : toolBar, "collectionView" : collectionView]
        var const = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[toolBar]-0-|", options: [], metrics: nil, views: views)
        const += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionView]-0-[toolBar]-0-|", options: [.AlignAllLeft, .AlignAllRight], metrics: nil, views: views)
        
        view.addConstraints(const)
        
        // 准备 collectionview
        prepareForCollectionView()
        
        // 准备 toolBar
        prepareForToolBar()
    }
    
    /// 准备 collectionview
    private func prepareForCollectionView() {
        // 注册 cell 设置数据源
        collectionView.registerClass(XFEmoticonCell.self, forCellWithReuseIdentifier: XFEmoticonCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    /// 准备 toolBar
    private func prepareForToolBar() {
        // 定义 toolbartitle
        let titles = ["最近", "默认", "Emoji", "浪小花"]
        
        // 遍历标题,创建 item
        var index = 0
        var temItems = [UIBarButtonItem]()
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .Plain, target: self, action: "itemClick:")
            item.tag = index
            index++
            
            temItems.append(item)
            temItems.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil))
        }
        
        // 设置toolBar 的 items 数据
        temItems.removeLast()
        toolBar.items = temItems
    }
}

// MARK:- 事件监听
extension XFEmoticonController {
    /// item 点击事件
    @objc private func itemClick(item : UIBarButtonItem) {
        
        // 获取点击 itemtag
        let tag = item.tag
        // 根据 tag获取当前组
        let indexPath = NSIndexPath(forItem: 0, inSection: tag)
        // 滚动到对应位置
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: true)
    }
}

// MARK: - UICollectionView数据源和代理方法
extension XFEmoticonController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // 根据 manager 里的包数量确定分区数
        return emoManager.packages.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 取出 package
        let package = emoManager.packages[section]
        // 根据包内表情数量确定 cell 数
        return package.emoticons.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(XFEmoticonCellID, forIndexPath: indexPath) as! XFEmoticonCell
        
        // 取出包
        let package = emoManager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.item]
        cell.emoticon = emoticon
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 取出点击的表情
        let package = emoManager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.item]
        
        // 将点击的表情添加到最近分组中
        insertRecentlyEmoticon(emoticon)
        
        // 将表情回调给外部控制器
        emoticonCallBack(emoticon: emoticon)
    }
    
    /// 添加到最近分组
    private func insertRecentlyEmoticon(emoticon : XFEmoticon) {
        // 如果是空白表情或者删除按钮, 就不需要添加
        if emoticon.isRemove || emoticon.isEmpty {
            return
        }
        
        // 如果已经有这个表情, 就将原来的删除
        if emoManager.packages.first!.emoticons.contains(emoticon) {
            let index = emoManager.packages.first?.emoticons.indexOf(emoticon)
            emoManager.packages.first?.emoticons.removeAtIndex(index!)
        } else {
            emoManager.packages.first?.emoticons.removeAtIndex(19)
        }
        
        // 添加
        emoManager.packages.first?.emoticons.insert(emoticon, atIndex: 0)
    }
}

// MARK:- 自定义布局
class EmoticonCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        // 1. 计算 item 的宽高
        let itemWH = UIScreen.mainScreen().bounds.width / 7
        
        // 2. 设置 layout 属性
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        
        // 3. 设置 collectionView 属性
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        let insetMargin = (collectionView!.bounds.height - 3 * itemWH) / 2
        collectionView?.contentInset = UIEdgeInsets(top: insetMargin, left: 0, bottom: insetMargin, right: 0)
    }
}






















