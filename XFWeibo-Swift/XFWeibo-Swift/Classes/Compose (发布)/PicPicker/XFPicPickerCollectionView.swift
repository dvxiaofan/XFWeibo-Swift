//
//  XFPicPickerCollectionView.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/13.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

private let XFPicPickerCellID = "picPickerCell"
private let margin : CGFloat = 15

class XFPicPickerCollectionView: UICollectionView {
    
    // MARK:- 定义属性
    var images : [UIImage] = [UIImage]() {
        didSet {
            reloadData()
        }
    }

    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置 layout
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (screenSize.width - 4 * margin) / 3
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        
        // 设置属性
        registerNib(UINib(nibName: "XFPicPickerCell", bundle: nil), forCellWithReuseIdentifier: XFPicPickerCellID)
        
        dataSource = self
        
        // 设置内边距
        contentInset = UIEdgeInsets(top: margin, left: margin, bottom: 0, right: margin)
    }
}

// MARK: - UICollectionViewDataSource
extension XFPicPickerCollectionView : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(XFPicPickerCellID, forIndexPath: indexPath) as! XFPicPickerCell
        
        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil
        
        return cell
    }
    
    
}










