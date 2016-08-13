//
//  XFCompTextView.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/12.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFCompTextView: UITextView {
    
    // MARK:- 懒加载
    lazy var placeHolderLabel : UILabel = UILabel()

    // MARK:- 添加子控件一般用这个方法
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
}

// MARK:- 设置界面
extension XFCompTextView {
    
    private func setupUI() {
        addSubview(placeHolderLabel)
        
        // frame (top, left)
        placeHolderLabel.frame = CGRect(x: 10, y: 5, width: 200, height: 30)
        
        // 属性
        placeHolderLabel.textColor = UIColor.lightGrayColor()
        placeHolderLabel.font = font
        
        // 文字
        placeHolderLabel.text = "分享新鲜事..."
        
        // 设置内容内边距
        textContainerInset = UIEdgeInsets(top: 9, left: 7, bottom: 0, right: 7)
    }
    
}













