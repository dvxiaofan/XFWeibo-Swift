//
//  XFShowBigPhotoController.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/16.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFShowBigPhotoController: UIViewController {
    // MARK:- 定义属性
    var indexPath : NSIndexPath
    var picURLs : [NSURL]
    
    // MARK:- 懒加载
    private lazy var collectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var moreBtn : UIButton = UIButton()
    
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
        
    }
    

}

// MARK:- 设置 UI 界面
extension XFShowBigPhotoController {
    
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(moreBtn)
        
        collectionView.frame = view.bounds
        //moreBtn.frame 
    }
}























