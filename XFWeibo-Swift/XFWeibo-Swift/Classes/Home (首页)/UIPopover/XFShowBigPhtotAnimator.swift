//
//  XFShowBigPhtotAnimator.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/17.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

// 面向协议开发
protocol XFAnimatorPresentedDelegate : NSObjectProtocol {
    func startRect(indexPath : NSIndexPath) -> CGRect
    func endRect(indexPath : NSIndexPath) -> CGRect
    func imageView(indexPath : NSIndexPath) -> UIImageView
}

protocol XFAnimatorDismissDelegate : NSObjectProtocol {
    func indexPathForDissmissView() -> NSIndexPath
    func imageViewForDissmissView() -> UIImageView
}

class XFShowBigPhtotAnimator: NSObject {
    
    var isPresented : Bool = false
    var presentedDelegate : XFAnimatorPresentedDelegate?
    var dismisDelegate : XFAnimatorDismissDelegate?
    var indexPath : NSIndexPath?
}

// MARK: - UIViewControllerTransitioningDelegate
extension XFShowBigPhtotAnimator : UIViewControllerTransitioningDelegate {
    /// 自定义弹出动画代理
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    /// 自定义消失动画代理
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}

extension XFShowBigPhtotAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        isPresented ? animationForPresentedView(transitionContext) : animationForDismissView(transitionContext)
        
    }
    
    /// 弹出动画
    func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let presentedDelegate = presentedDelegate, indexPath = indexPath else {
            return
        }
        
        // 取出弹出 view
        let presnetedView = transitionContext.viewForKey(UITransitionContextToViewKey)
        
        // 添加到 contentView
        transitionContext.containerView()?.addSubview(presnetedView!)
        
        // 获取执行动画的 imageView
        let startRect = presentedDelegate.startRect(indexPath)
        let imageView = presentedDelegate.imageView(indexPath)
        transitionContext.containerView()?.addSubview(imageView)
        imageView.frame = startRect
        
        // 执行动画
        presnetedView?.alpha = 0.0
        transitionContext.containerView()?.backgroundColor = UIColor.blackColor()
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            imageView.frame = presentedDelegate.endRect(indexPath)
            }) { (_) -> Void in
                imageView.removeFromSuperview()
                presnetedView?.alpha = 1.0
                transitionContext.completeTransition(true) // 完成动画
        }
    }
    
    /// 消失动画
    func animationForDismissView(transitionContext: UIViewControllerContextTransitioning) {
        // 空值校验
        guard let dismisDelegate = dismisDelegate, presentedDelegate = presentedDelegate else {
            return
        }
        
        let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        dismissView?.removeFromSuperview()
        
        // 获取执行动画的 imageView
        let imageView = dismisDelegate.imageViewForDissmissView()
        // 必须要有父控件
        transitionContext.containerView()?.addSubview(imageView)
        let indexPath = dismisDelegate.indexPathForDissmissView()
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            imageView.frame = presentedDelegate.startRect(indexPath)
            dismissView?.alpha = 0.0
            }) { (_) -> Void in
                transitionContext.completeTransition(true)
        }
    }
}


















