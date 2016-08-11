//
//  XFHomeViewCell.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/11.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

private let edgeMargin : CGFloat = 15

class XFHomeViewCell: UITableViewCell {
    // MARK:- 拖线属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var verifidTypeView: UIImageView!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var createAtLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK:- 约束属性
    @IBOutlet weak var contentLabelWidthCons: NSLayoutConstraint!
    
    // MARK:- 自定义属性
    var viewModel : XFStatusViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            // 头像
            iconView.sd_setImageWithURL(viewModel.profileURL, placeholderImage: UIImage(named: "avatar_default_small"))
            
            // 认证
            verifidTypeView.image = viewModel.verifiedImage
            
            // vip
            vipView.image = viewModel.vipImage
            
            // 昵称
            screenNameLabel.text = viewModel.status?.user?.screen_name
            
            // 昵称颜色
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.blackColor() : UIColor.orangeColor()
            
            // 时间
            createAtLabel.text = viewModel.createdAtText
            
            // 来源
            sourceLabel.text = viewModel.sourceText
            
            // 正文
            contentLabel.text = viewModel.status?.text
            
        }
    }

    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置正文宽度约束
        contentLabelWidthCons.constant = screenSize.width - 2 * edgeMargin
    }

}


















