//
//  XFStatusViewModel.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/11.
//  Copyright © 2016年 xiaofan. All rights reserved.
// 视图模型帮助处理数据
//

import UIKit

class XFStatusViewModel: NSObject {
    // MARK:- 定义属性
    var status : XFHomeStatus?
    
    var cellHeight : CGFloat = 0
    
    // MARK:- 自定义数据处理属性
    var sourceText : String?            // 处理来源数据
    var createdAtText : String?         // 处理创建时间
    var verifiedImage : UIImage?        // 处理认证类型图片
    var vipImage : UIImage?             // 处理会员等级图片
    var profileURL : NSURL?             // 处理用户头像 URL
    var picURLs : [NSURL] = [NSURL]()   // 处理配图数据
    
    // MARK:- 自定义构造函数
    init(status : XFHomeStatus) {
        self.status = status
        
        // 1. 处理来源
        // 空值校验(if 判断可选绑定, 如果后面还有条件,要用 where)
        if let source = status.source where source != "" {
            // 对来源字符串进行处理
            let startIndex = (source as NSString).rangeOfString(">").location + 1
            let length = (source as NSString).rangeOfString("</").location - startIndex
            
            sourceText = (source as NSString).substringWithRange(NSRange(location: startIndex, length: length))
        }
        
        // 2. 处理时间
        if let createdAt = status.created_at {
            createdAtText = NSDate.createrDateString(createdAt)
        }
        
        // 3. 处理认证类型图片
        let verifiedType = status.user?.verified_type ?? -1
            
        switch verifiedType {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        // 4. 处理会员等级图片
        let mbrank = status.user?.mbrank ?? 0
        
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        // 5. 处理头像 URL
        let profileString = status.user?.profile_image_url ?? ""
        profileURL = NSURL(string: profileString)
        
        // 6. 处理配图数据
        // 判断图片数据来源
        let picURLDicts = status.pic_urls!.count != 0 ? status.pic_urls : status.retweeted_status?.pic_urls
        
        if let picURLDicts = picURLDicts {
            for picURLDict in picURLDicts {
                guard let picURLString = picURLDict["thumbnail_pic"] else {
                    continue
                }
                picURLs.append(NSURL(string: picURLString)!)
                
            }
        }
        
    }
}

















