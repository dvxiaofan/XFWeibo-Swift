//
//  XFShowBigPhotoController.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/16.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

private let XFShowBigPhotoCellID = "XFShowBigPhotoCellID"

class XFShowBigPhotoController: UIViewController {
    // MARK:- 定义属性
    var indexPath : NSIndexPath
    var picURLs : [NSURL]
    
    // MARK:- 懒加载
    private lazy var collectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: XFShowBigPhotoCollectionViewLayout())
    private lazy var moreBtn : UIButton = UIButton()
    private lazy var showLabel : UILabel = UILabel()
    
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
    override func loadView() {
        super.loadView()
        // 为了设置 scrollView 的间隔, 先讲控制器宽加20,然后再 scrollView 宽度减20
        view.frame.size.width += 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI 界面
        setupUI()
        
        // 滚动到对应图片
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
    }
}

// MARK:- 设置 UI 界面
extension XFShowBigPhotoController {
    
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(moreBtn)
        view.addSubview(showLabel)
        
        collectionView.frame = view.bounds
        
        moreBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(30)
            make.right.equalTo(-35)
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
        
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let action = UIAlertAction(title: "保存图片", style: .Default) { (action) -> Void in
            let cell = self.collectionView.visibleCells().first as! XFShowBigPhotoCell
            guard let image = cell.imageView.image else {
                return
            }
            
            //将图片保存到相册中
            UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSaveingWithError:contextInfo:", nil)
        }
        
        let action1 = UIAlertAction(title: "转发微博", style: .Default) { (action) -> Void in
            XFLog("转发微博")
        }
        
        let action2 = UIAlertAction(title: "赞", style: .Default) { (action) -> Void in
            XFLog("赞")
        }
        
        let action3 = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        
        alertSheet.addAction(action)
        alertSheet.addAction(action1)
        alertSheet.addAction(action2)
        alertSheet.addAction(action3)
        
        presentViewController(alertSheet, animated: true, completion: nil)
    }
    
    @objc private func image(image : UIImage, didFinishSaveingWithError error : NSError?, contextInfo : AnyObject) {
        var errorInfo = ""
        if error != nil {
            errorInfo = "保存失败"
        } else {
            errorInfo = "保存成功"
        }
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showInfoWithStatus(errorInfo)
    }
}

// MARK: - UICollectionView 数据源
extension XFShowBigPhotoController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(XFShowBigPhotoCellID, forIndexPath: indexPath) as! XFShowBigPhotoCell
        
        cell.picURL = picURLs[indexPath.item]
        cell.delegate = self
        
        return cell
    }
}

// MARK: - XFShowBigPhotoCell代理
extension XFShowBigPhotoController : XFShowBigPhotoCellDelegate {
    func imageTap() {
        closeAction()
    }
}

// MARK: - XFAnimatorDismiss 代理
extension XFShowBigPhotoController : XFAnimatorDismissDelegate {
    
    func indexPathForDissmissView() -> NSIndexPath {
        // 获取正在显示的 indexPath
        let cell = collectionView.visibleCells().first!
        
        return collectionView.indexPathForCell(cell)!
    }
    
    func imageViewForDissmissView() -> UIImageView {
        // 创建 uiimageView 对象
        let imageView = UIImageView()
        
        let cell = collectionView.visibleCells().first as! XFShowBigPhotoCell
        
        imageView.frame = cell.imageView.frame
        imageView.image = cell.imageView.image
        
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true 
        
        return imageView
    }
    
}

// MARK:- 自定义 Layout
class XFShowBigPhotoCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        
        itemSize = collectionView!.frame.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        
        collectionView?.pagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}




















