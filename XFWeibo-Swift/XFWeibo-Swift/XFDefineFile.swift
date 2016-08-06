//
//  XFDefineFile.swift
//
//  Created by xiaofans on 16/8/5.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

/**
 自定义 log
 
 - parameter message:    打印的内容
 - parameter file:       所在文件
 - parameter lineNumber: 所在行数
 */
func XFLog<T>(message : T, file : String = __FILE__, lineNumber : Int = __LINE__) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):line:\(lineNumber)]- \(message)")
        
    #endif
}








