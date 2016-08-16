//
//  XFHomeViewCell.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/11.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit
import SDWebImage
import HYLabel

private let edgeMargin : CGFloat = 15
private let picMargin : CGFloat = 10

class XFHomeViewCell: UITableViewCell {
    // MARK:- 拖线属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var verifidTypeView: UIImageView!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var createAtLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: HYLabel!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var zanButton: UIButton!
    @IBOutlet weak var retweetBgView: UIView!
    @IBOutlet weak var bottomToolView: UIView!
    
    @IBOutlet weak var picView: XFPicCollectionView!
    @IBOutlet weak var retweetedLabel: HYLabel!
    
    // MARK:- 约束属性
    @IBOutlet weak var contentLabelWidthCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWidthCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHieghtCons: NSLayoutConstraint!
    @IBOutlet weak var picViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var retweetContentTopCons: NSLayoutConstraint!
    @IBOutlet weak var reteetContentBottomCons: NSLayoutConstraint!
    
    // MARK:- 自定义属性
    var viewModel : XFStatusViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            // 1.头像
            iconView.sd_setImageWithURL(viewModel.profileURL, placeholderImage: UIImage(named: "avatar_default_small"))
            
            // 2.认证
            verifidTypeView.image = viewModel.verifiedImage
            
            // 3.vip
            vipView.image = viewModel.vipImage
            
            // 4.昵称
            screenNameLabel.text = viewModel.status?.user?.screen_name
            
            // 5.昵称颜色
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.blackColor() : UIColor.orangeColor()
            
            // 6.时间
            createAtLabel.text = viewModel.createdAtText
            
            // 7.来源
            if let sourceText = viewModel.sourceText {
                sourceLabel.text = "来自" + sourceText
            } else {
                sourceLabel.text = nil
            }
            
            // 8.正文
            contentLabel.attributedText = XFFindEmoticom.shareInstance.findAttrString(viewModel.status?.text, font: contentLabel.font)
            
            // 9.转发数
            if let repostCount = viewModel.status?.reposts_count where repostCount != 0  {
                
                repostButton.setTitle("\(repostCount)", forState: .Normal)
            }
            
            // 10.评论数
            if let commentCount = viewModel.status?.comments_count where commentCount != 0  {
                
                commentButton.setTitle("\(commentCount)", forState: .Normal)
            }
            
            // 11.点赞数
            if let zanCount = viewModel.status?.attitudes_count where zanCount != 0 {
                zanButton.setTitle("\(zanCount)", forState: .Normal)
            }
            
            // 12.计算配图 view 宽度和高度约束
            let picViewSize = calculatePicViewSize(viewModel.picURLs.count)
            picViewWidthCons.constant = picViewSize.width
            picViewHieghtCons.constant = picViewSize.height
            
            // 13.将 picURL 数据传递给 picview
            picView.picURLs = viewModel.picURLs
            
            // 14. 设置转发微博正文 和背景颜色
            if viewModel.status?.retweeted_status != nil {
                
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name,  retContent = viewModel.status?.retweeted_status?.text {
                    
                    let retweetedText = "@" + "\(screenName): " + retContent
                    retweetedLabel.attributedText = XFFindEmoticom.shareInstance.findAttrString(retweetedText, font: retweetedLabel.font)
                    
                    // 设置转发正文顶部约束
                    retweetContentTopCons.constant = 15
                }
                retweetBgView.hidden = false
                
            } else {
                retweetedLabel.text = nil
                retweetBgView.hidden = true
                // 设置转发正文顶部约束
                retweetContentTopCons.constant = 0
            }
            
            // 15. 计算 cell 高度
            if viewModel.cellHeight == 0 {
                //15.1 先强制布局
                layoutIfNeeded()
                // 15.2 获取底部工具类最大 y 值
                viewModel.cellHeight = CGRectGetMaxY(bottomToolView.frame)
            }
        }
    }

    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置正文宽度约束
        contentLabelWidthCons.constant = screenSize.width - 2 * edgeMargin
        
        // HYLabel 内容属性
        //contentLabel.matchTextColor = UIColor.orangeColor()
        //retweetedLabel.matchTextColor = contentLabel.matchTextColor
        
        /// 监听内容点击 原创
        contentLabel.userTapHandler = { (label, user, range) in
            XFLog(user)
            XFLog(range)
        }
        contentLabel.linkTapHandler = { (label, link, range) in
            XFLog(link)
            XFLog(range)
        }
        contentLabel.topicTapHandler = { (label, topic, range) in
            XFLog(topic)
            XFLog(range)
        }
        // 转发微博
        retweetedLabel.userTapHandler = { (label, user, range) in
            XFLog(user)
            XFLog(range)
        }
        retweetedLabel.linkTapHandler = { (label, link, range) in
            XFLog(link)
            XFLog(range)
        }
        retweetedLabel.topicTapHandler = { (label, topic, range) in
            XFLog(topic)
            XFLog(range)
        }
    }
}

// MARK:- 计算
extension XFHomeViewCell {
    /// 计算配图 view 宽度和高度约束
    private func calculatePicViewSize(count : Int) -> CGSize {
        // 1. 没有配图 , 底部约束为0
        if count == 0 {
            picViewBottomCons.constant = 0
            reteetContentBottomCons.constant = 5;
            return CGSizeZero
        }
        
        // 有配图, 底部约束有值
        picViewBottomCons.constant = 10
        
        // 2.取出picView 对应 layout
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
        
        // 3.单张图片
        if count == 1 {
            // 取出图片
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(viewModel?.picURLs.last?.absoluteString)
            // 单张图片的 layoutsize
            layout.itemSize = CGSize(width: image.size.width * 2, height: image.size.height * 2)
            
            return CGSize(width: image.size.width * 2, height: image.size.height * 2)
        }
        
        // 4.计算出来 imageView 宽高
        let imageViewWH = (screenSize.width - 2 * edgeMargin - 2 * picMargin) / 3
        
        // 5. 设置其余图layout.itemSize
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
        // 6. 四张图
        if count == 4 {
            let picViewWH = imageViewWH * 2 + picMargin + 1
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        // 7. 其他张,先计算行数
        // 7.1 计算行数
        let rowsCount = CGFloat((count - 1) / 3 + 1)
        
        // 7.2 计算 picview 高度
        let picViewH = rowsCount * imageViewWH + (rowsCount - 1) * picMargin
        
        // 7.3 计算 picview 宽度
        let picViewW = screenSize.width - 2 * edgeMargin
        
        return CGSize(width: picViewW, height: picViewH)
        
    }
}















