//
//  XFCompTitleView.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/12.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit
import SnapKit

class XFCompTitleView: UIView {
    
    // MARK:- 懒加载
    private lazy var titleLabel : UILabel = UILabel()
    private lazy var screenNameLabel : UILabel = UILabel()

    // MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置界面
        setupView()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置界面
extension XFCompTitleView {
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        
        // 设置 frame
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        screenNameLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(titleLabel.snp_centerX)
            make.top.equalTo(titleLabel.snp_bottom).offset(3)
        }
        
        // 设置属性
        titleLabel.font = UIFont.systemFontOfSize(16)
        screenNameLabel.font = UIFont.systemFontOfSize(14)
        screenNameLabel.textColor = UIColor.lightGrayColor()
        
        // 设置文字
        titleLabel.text = "发微博"
        screenNameLabel.text = XFUserAccountTool.shareInstance.account?.screen_name
        
        
    }
}










