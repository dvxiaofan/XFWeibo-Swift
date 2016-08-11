//
//  NSDate-Extension.swift
//  时间处理demo
//
//  Created by xiaofans on 16/8/11.
//  Copyright © 2016年 xiaofan. All rights reserved.
// 外界直接调用 NSDate.createrDateString(传入起始时间)
//

import Foundation

extension NSDate {
    class func createrDateString(createAt : String) -> String {
        // 1. 创建时间格式化队形
        let fmt = NSDateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = NSLocale(localeIdentifier: "en")
        
        // 2. 将字符串时间转成 nsdate
        guard let createDate = fmt.dateFromString(createAt) else {
            return ""
        }
        
        // 创建当前时间
        let nowDate = NSDate()
        
        // 计算时间差
        let interval = Int(nowDate.timeIntervalSinceDate(createDate))
        
        if interval < 60 {
            return "刚刚"
        }
        
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        // 昨天  创建日历对象
        let calendar = NSCalendar.currentCalendar()
        
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.stringFromDate(createDate)
            return timeStr
        }
        
        // 一年之内
        let cmp = calendar.components(.Year, fromDate: createDate, toDate: nowDate, options: [])
        if cmp.year < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.stringFromDate(createDate)
            return timeStr
        }
        
        // 超过一年
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.stringFromDate(createDate)
        return timeStr
    }
}
