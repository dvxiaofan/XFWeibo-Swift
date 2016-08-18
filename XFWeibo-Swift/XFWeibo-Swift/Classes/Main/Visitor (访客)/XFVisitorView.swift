
//
//  XFVisitorView.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/6.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFVisitorView: UIView {

    class func vistitorView() -> XFVisitorView {
        return NSBundle.mainBundle().loadNibNamed("XFVisitorView", owner: nil
            , options: nil).first as! XFVisitorView
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    // MARK:- 自定义函数
    func setupVisitorViewInfo(iconName : String, title : String) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.hidden = true 
    }
    
    /// 增加动画
    func addRotationAnim() {
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 8
        rotationAnim.removedOnCompletion = false
        
        rotationView.layer.addAnimation(rotationAnim, forKey: nil)
    }
    

}












