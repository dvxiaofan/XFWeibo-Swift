//
//  XFWelcomeViewController.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/10.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit
import SDWebImage

class XFWelcomeViewController: UIViewController {
    
    // MARK:- 拖线属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!

    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置头像
        let profileUrl = XFUserAccountTool.shareInstance.account?.avatar_large
        // ?? 如果前面的可选类型有值, 那么将前面的可选类型解包并赋值
        // 如果前面的可选类型么有值, 那直接使用??后面的值
        let url = NSURL(string: profileUrl ?? "")
        iconView.sd_setImageWithURL( url, placeholderImage: UIImage(named: "avatar_default_big"))
        
        // 改变约束值
        iconViewBottomCons.constant = screenSize.height - 220
        
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                // 显示主窗口
                UIApplication.sharedApplication().keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
        
    }
}












