//
//  XFCompTitleView.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/12.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

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
        //titleLabel.snp_makeConstraints { (make) -
            //> Void in
            //make.centerX.equalTo(self)
            //make.top.equalTo(self)
        //}
        //screenNameLabel.anp_makeConstraints { (make) -> Void in
            //make.centeX.erqualTo(titleLabel.snp_centerX)
            //make.top.equalTo(titleLabel.snp_bottom).offset(3)
            
        //}
        let titleWidth : CGFloat = 160
        let titleH : CGFloat = 18
        let titleX = (screenSize.width - titleWidth) * 0.5 - 45
        
        titleLabel.frame = CGRect(x: titleX, y: 0, width: titleWidth, height: titleH)
        
        screenNameLabel.frame = CGRect(x: titleX - 10, y: (CGRectGetMaxY(titleLabel.frame) + 5), width: 180, height: titleH)
        
        // 设置属性
        titleLabel.font = UIFont.systemFontOfSize(16)
        screenNameLabel.font = UIFont.systemFontOfSize(14)
        screenNameLabel.textColor = UIColor.lightGrayColor()
        
        // 设置文字
        titleLabel.text = "发微博"
        screenNameLabel.text = XFUserAccountTool.shareInstance.account?.screen_name
        
        
    }
}










