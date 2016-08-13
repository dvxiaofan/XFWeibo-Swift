//
//  XFCompViewController.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/12.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFCompViewController: UIViewController {
    
    // MARK:- 拖线属性
    @IBOutlet weak var textView: XFCompTextView!
    
    // MARK:- 约束属性
    @IBOutlet weak var toolBottomCons: NSLayoutConstraint!
    @IBOutlet weak var pickerViewHeightCons: NSLayoutConstraint!
    
    
    // MARK:- 懒加载
    private lazy var titleView : XFCompTitleView = XFCompTitleView()

    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏
        setupNavBar()
        
        // 监听通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

// MARK:- 设置界面
extension XFCompViewController {
    /// 设置导航栏
    private func setupNavBar() {
        UINavigationBar.appearance().tintColor = UIColor.darkGrayColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "backClick")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .Plain, target: self, action: "sendClick")
        navigationItem.rightBarButtonItem?.enabled = false
        
        navigationItem.titleView = titleView
        titleView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
    }
    
}

// MARK:- 事件监听
extension XFCompViewController {
    /// 返回按钮点击事件
    @objc private func backClick() {
         dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// 发送按钮
    @objc private func sendClick() {
        XFLog("发送按钮")
    }
    
    /// 键盘通知监听
    @objc private func KeyboardWillChangeFrame(note : NSNotification) {
        // 获得动画执行的时间
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        // 获取键盘最终的 y 值. 先转成 nsvalue,  拿到里面的CGRectValue
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let keyBoardY = endFrame.origin.y
        
        // 计算工具栏距离底部的高度
        let margin = screenSize.height - keyBoardY
        
        // 执行动画
        toolBottomCons.constant = margin
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    /// 选择图片
    @IBAction func picPickerClick(sender: AnyObject) {
        // 退出键盘
        textView.resignFirstResponder()
        
        // 执行动画
        pickerViewHeightCons.constant = screenSize.height * 0.6
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    
}

// MARK: - 代理事件
extension XFCompViewController : UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        self.textView.placeHolderLabel.hidden = textView.hasText()
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        navigationItem.rightBarButtonItem?.tintColor = UIColor.orangeColor()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        textView.resignFirstResponder()
        
    }
}












