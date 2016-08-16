//
//  XFPicCollectionView.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/11.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFPicCollectionView: UICollectionView {
    
    // MARK:- 定义属性
    var picURLs : [NSURL] = [NSURL]() {
        didSet {
            self.reloadData()
        }
    }
    
     //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource = self
        delegate = self
    }

}

// MARK: - UICollectionView数据源和代理
extension XFPicCollectionView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 获取 cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("picCell", forIndexPath: indexPath) as! XFPicCollectionViewCell
        
        // 给 cell 设置数据
        cell.picURL = picURLs[indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 获取通知需要传递的啊参数
        let userInfo = [XFShowBigPhtotIndexKey : indexPath, XFShowBigPhtotURLsKey : picURLs]
        
        NSNotificationCenter.defaultCenter().postNotificationName(XFShowBigPhtotNote, object: nil, userInfo: userInfo)
    }
}

// MARK:-  piccell 类
class XFPicCollectionViewCell: UICollectionViewCell {
    
    // MARK:- 模型属性
    var picURL : NSURL? {
        didSet {
            guard let picURL = picURL else {
                return
            }
            pictureView.sd_setImageWithURL(picURL, placeholderImage: UIImage(named: "timeline_image_placeholder"))
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var pictureView: UIImageView!
    
    
}



















