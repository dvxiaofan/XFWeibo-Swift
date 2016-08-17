//
//  XFShowBigPhotoController.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/16.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit
import SnapKit

private let XFShowBigPhotoCellID = "XFShowBigPhotoCellID"

class XFShowBigPhotoController: UIViewController {
    // MARK:- 定义属性
    var indexPath : NSIndexPath
    var picURLs : [NSURL]
    
    // MARK:- 懒加载
    private lazy var collectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: XFShowBigPhotoCollectionViewLayout())
    private lazy var moreBtn : UIButton = UIButton()
    private lazy var showLabel : UILabel = UILabel()
    
    // 测试用
    private lazy var closeBtn : UIButton = UIButton()
    
    // MARK:- 自定义构造函数
    init(indexPath : NSIndexPath, picURLs : [NSURL]) {
        self.indexPath = indexPath
        self.picURLs = picURLs
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI 界面
        setupUI()
        
        // 滚动到对应图片
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
    }
    
    override func loadView() {
        super.loadView()
        // 为了设置 scrollView 的间隔, 先讲控制器宽加20,然后再 scrollView 宽度减20
        view.bounds.size.width += 20
    }
}

// MARK:- 设置 UI 界面
extension XFShowBigPhotoController {
    
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(moreBtn)
        view.addSubview(showLabel)
        
        view.addSubview(closeBtn)
        closeBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(30)
            make.left.equalTo(15)
            make.size.equalTo(CGSize(width: 40, height: 30))
        }
        closeBtn.setTitle("关闭", forState: .Normal)
        closeBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        closeBtn.addTarget(self, action: "closeAction", forControlEvents: .TouchUpInside)
        
        collectionView.frame = view.bounds
        
        moreBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(30)
            make.right.equalTo(-15)
            make.size.equalTo(CGSize(width: 40, height: 30))
        }
        moreBtn.setImage(UIImage(named: "navigationbar_more1"), forState: .Normal)
        moreBtn.setImage(UIImage(named: "navigationbar_more_highlighted"), forState: .Highlighted)
        
        showLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(moreBtn.snp_centerY)
            make.centerX.equalTo(view)
        }
        showLabel.text = "1/\(picURLs.count)"
        showLabel.textColor = UIColor.whiteColor()
        
        // 设置 collection 属性
        collectionView.registerClass(XFShowBigPhotoCell.self, forCellWithReuseIdentifier: XFShowBigPhotoCellID)
        
        collectionView.dataSource = self
        
        // 点击事件监听
        moreBtn.addTarget(self, action: "moreBtnClick", forControlEvents: .TouchUpInside)
        
    }
}

// MARK:- 事件监听
extension XFShowBigPhotoController {
    
    @objc private func closeAction() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func moreBtnClick() {
        XFLog("更多")
    }
}

// MARK: - UICollectionView 数据源和代理
extension XFShowBigPhotoController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(XFShowBigPhotoCellID, forIndexPath: indexPath) as! XFShowBigPhotoCell
        
        cell.picURL = picURLs[indexPath.item]
        
        return cell
    }
}

// MARK:- 自定义 Layout
class XFShowBigPhotoCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        itemSize = collectionView!.frame.size
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        scrollDirection = .Horizontal
        collectionView?.pagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}




















