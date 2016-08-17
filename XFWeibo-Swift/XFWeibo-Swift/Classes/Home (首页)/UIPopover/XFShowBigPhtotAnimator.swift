//
//  XFShowBigPhtotAnimator.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/17.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

class XFShowBigPhtotAnimator: NSObject {

    var isPresented : Bool = false

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
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        isPresented ? animationForPresentedView(transitionContext) : animationForDismissView(transitionContext)
        
    }
    
    /// 弹出动画
    func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning) {
        // 取出弹出 view
        let presnetedView = transitionContext.viewForKey(UITransitionContextToViewKey)
        
        // 添加到 contentView
        transitionContext.containerView()?.addSubview(presnetedView!)
        
        // 执行动画
        presnetedView?.alpha = 0.0
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            presnetedView?.alpha = 1.0
            }) { (_) -> Void in
                transitionContext.completeTransition(true) // 完成动画
        }
    }
    
    /// 消失动画
    func animationForDismissView(transitionContext: UIViewControllerContextTransitioning) {
        let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            dismissView?.alpha = 0.0
            }) { (_) -> Void in
                dismissView?.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
    }
}


















