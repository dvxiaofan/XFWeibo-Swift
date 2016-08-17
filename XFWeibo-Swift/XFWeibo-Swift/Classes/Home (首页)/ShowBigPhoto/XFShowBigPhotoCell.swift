//
//  XFShowBigPhotoCell.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/17.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit
import SDWebImage

protocol XFShowBigPhotoCellDelegate : NSObjectProtocol {
    func imageTap()
}

class XFShowBigPhotoCell: UICollectionViewCell {
    
    // MARK:- 对外属性
    var picURL : NSURL? {
        didSet {
            setupContent(picURL)
        }
    }
    
    var delegate : XFShowBigPhotoCellDelegate?
    
    // MARK:- 懒加载
    private lazy var scroView : UIScrollView = UIScrollView()
    private lazy var progressView : XFProgressView = XFProgressView()
    lazy var imageView : UIImageView = UIImageView()
    
    // MARK:- 自定义构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

 // MARK:- 设置 UI 界面
extension XFShowBigPhotoCell {
    
    private func setupUI() {
        contentView.addSubview(scroView)
        contentView.addSubview(imageView)
        contentView.addSubview(progressView)
        
        scroView.frame = contentView.bounds
        scroView.frame.size.width -= 20
        progressView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        progressView.center = CGPoint(x: screenSize.width * 0.5, y: screenSize.height * 0.5)
        
        progressView.hidden = true
        progressView.backgroundColor = UIColor.clearColor()
        
        // 监听 imageView 的点击
        imageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "imageTap")
        imageView.addGestureRecognizer(tap)
    }
}

// MARK:- 事件监听
extension XFShowBigPhotoCell {
    
    @objc private func imageTap() {
        delegate?.imageTap()
    }
}

// MARK:- 设置 imageView 图片
extension XFShowBigPhotoCell {
    
    private func setupContent(picURL : NSURL?) {
        // 校验空值
        guard let picURL = picURL else {
            return
        }
        
        // 得到 image
        let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(picURL.absoluteString)
        
        // 计算 imageviewframe
        let imgX : CGFloat = 0
        let imgWidth = screenSize.width
        let imgHeight = imgWidth / image.size.width * image.size.height
        
        var imgY : CGFloat = 0
        if imgHeight > screenSize.height {
            imgY = 0
        } else {
            imgY = (screenSize.height - imgHeight) * 0.5
        }
        imageView.frame = CGRect(x: imgX, y: imgY, width: imgWidth, height: imgHeight)
        
        // 设置图片
        progressView.hidden = false
        
        imageView.sd_setImageWithURL(getBigURL(picURL), placeholderImage: image, options: [], progress: { (current, total) -> Void in
            self.progressView.progress = CGFloat(current) / CGFloat(total)
            }) { (_, _, _, _) -> Void in
              self.progressView.hidden = true
        }
        
        // 设置 scrollView 的 contentsize
        scroView.contentSize = CGSize(width: 0, height: imgHeight)
    }
    
    // 获得大图 url
    private func getBigURL(smallURL : NSURL) -> NSURL {
        let smallURLStr = smallURL.absoluteString
        let bigRUL = smallURLStr.stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle")
        return NSURL(string: bigRUL)!
    }
}
















