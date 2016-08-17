//
//  XFPicCollectionView.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/11.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit
import SDWebImage

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
        
        // object 改为 self  传递 object
        NSNotificationCenter.defaultCenter().postNotificationName(XFShowBigPhtotNote, object: self, userInfo: userInfo)
    }
}

// MARK: - XFAnimatorPresentedDelegate
extension XFPicCollectionView: XFAnimatorPresentedDelegate {
    
    func startRect(indexPath: NSIndexPath) -> CGRect {
        // 获取 cell
        let cell = self.cellForItemAtIndexPath(indexPath)!
        
        // 获得 frame . 需要拿到相对于窗口的 frame
        let startRect = self.convertRect(cell.frame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
        
        return startRect
    }
    
    func endRect(indexPath: NSIndexPath) -> CGRect {
        // 获取该位置的 image 对象
        let picURL = picURLs[indexPath.item]
        let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(picURL.absoluteString)
        
        // 计算结束后的 frame
        let endWidth = screenSize.width
        let endHeight = endWidth / image.size.width * image.size.height
        var endY : CGFloat = 0
        if endHeight > screenSize.height {
            endY = 0
        } else {
            endY = (screenSize.height - endHeight) * 0.5
        }
        
        return CGRect(x: 0, y: endY, width: endWidth, height: endHeight)
        
    }
    
    func imageView(indexPath: NSIndexPath) -> UIImageView {
        let imageView = UIImageView()
        
        let picURL = picURLs[indexPath.item]
        let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(picURL.absoluteString)
        
        imageView.image = image
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
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




















