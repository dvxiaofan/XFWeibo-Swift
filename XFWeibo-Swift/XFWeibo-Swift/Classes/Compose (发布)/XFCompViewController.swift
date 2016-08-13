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
    @IBOutlet weak var picPickerView: XFPicPickerCollectionView!
    
    // MARK:- 约束属性
    @IBOutlet weak var toolBottomCons: NSLayoutConstraint!
    @IBOutlet weak var pickerViewHeightCons: NSLayoutConstraint!
    
    
    // MARK:- 懒加载
    private lazy var titleView : XFCompTitleView = XFCompTitleView()
    private lazy var images : [UIImage] = [UIImage]()

    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏
        setupNavBar()
        
        // 监听通知
        setupNotifications()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    // 移除通知
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
    
    /// 监听通知
    private func setupNotifications() {
        // 键盘通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        // 增加照片通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pickerAddPhoto", name: XFPickerAddPhotoNote, object: nil)
        // 移除已选择照片
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pickerDeletedPhoto:", name: XFPickerDeletedPhotoNote, object: nil)
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
    
    /// 选择图片界面弹出
    @IBAction func picPickerClick(sender: AnyObject) {
        // 退出键盘
        textView.resignFirstResponder()
        
        // 执行动画
        pickerViewHeightCons.constant = screenSize.height * 0.65
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
}

// MARK:- 添加和删除照片
extension XFCompViewController {
    /// 添加照片
    @objc private func pickerAddPhoto() {
        // 1. 判断照片源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            return
        }
        
        // 2. 创建照片选择控制器
        let imgPicController = UIImagePickerController()
        
        // 3. 设置照片源
        imgPicController.sourceType = .PhotoLibrary
        
        // 4. 设置代理
        imgPicController.delegate = self
        
        // 5. 弹出控制器
        presentViewController(imgPicController, animated: true, completion: nil)
        
    }
    
    /// 删除已选照片
    @objc private func pickerDeletedPhoto(note : NSNotification) {
        // 拿到要删除的图片
        guard let image = note.object as? UIImage else {
            return
        }
        // 拿到图片下标
        guard let index = images.indexOf(image) else {
            return
        }
        // 删除图片
        images.removeAtIndex(index)
        // 重新赋值数组
        picPickerView.images = images
    }
}

// MARK: - 选择图片代理
extension XFCompViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // 获得选中图片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // 添加到数组中
        images.append(image)
        
        // 讲数组赋值给 collection
        picPickerView.images = images
        
        // 退出
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - textView代理事件
extension XFCompViewController : UITextViewDelegate {
    /// textView开始编辑
    func textViewDidChange(textView: UITextView) {
        self.textView.placeHolderLabel.hidden = textView.hasText()
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        navigationItem.rightBarButtonItem?.tintColor = UIColor.orangeColor()
    }
    /// 滚动textView
    func scrollViewDidScroll(scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}












