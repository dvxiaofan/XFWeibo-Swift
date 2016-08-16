//
//  XFEmoticonCell.swift
//  表情键盘
//
//  Created by xiaofans on 16/8/15.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFEmoticonCell: UICollectionViewCell {
    
    // MARK:- 定义属性
    var emoticon : XFEmoticon? {
        didSet {
            guard let emoticon = emoticon else {
                return
            }
            // 设置 emoticonBtn 属性
            emoticonBtn.setImage(UIImage(contentsOfFile: emoticon.pngPath ?? ""), forState: .Normal)
            emoticonBtn.setTitle(emoticon.emojiCode, forState: .Normal)
            
            // 设置按钮. 根据是否是最后一个删除表情
            if emoticon.isRemove {
                emoticonBtn.setImage(UIImage(named: "compose_emotion_delete"), forState: .Normal)
                emoticonBtn.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: .Highlighted)
            }
        }
    }
    
    // MARK:- 懒加载
    private lazy var emoticonBtn : UIButton = UIButton()
    
    // MARK:- 重写构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:-  设置 UI 界面
extension XFEmoticonCell {
    
    private func setupUI() {
        contentView.addSubview(emoticonBtn)
        
        emoticonBtn.frame = contentView.bounds
        
        emoticonBtn.userInteractionEnabled = false
        
        emoticonBtn.titleLabel?.font = UIFont.systemFontOfSize(32)
        
    }
}



















