//
//  XFPopAnimator.swift
//
//
//  Created by xiaofans on 16/8/10.
//  Copyright © 2016年 xiaofan. All rights reserved.
//
// 其他类调用只需要懒加载创建一个该类对象, 然后将transitioningDelegate设置为该类

import UIKit

class XFPopAnimator: NSObject {
    // MARK:- 属性
    var isPresented : Bool = false
}

// MARK: - 自定义转场动画
extension XFPopAnimator: UIViewControllerTransitioningDelegate {
    // 改变弹出 view 的尺寸
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return XFPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    // 自定义弹出动画
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    // 自定义消失动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}

// MARK:- 弹出和消失动画代理
extension XFPopAnimator: UIViewControllerAnimatedTransitioning {
    // 动画执行的时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.2
    }
    
    // 获得转场上下文, 可以通过转场上下文获取到弹出的 view 和消失的 view
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animationForPresentedView(transitionContext) : animationForDismissView(transitionContext)
        
    }
    
    // MARK:- 自定义弹出动画
    private func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning) {
        // 获取弹出 view
        let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        // 将弹出的 view 添加到 contentView 中
        transitionContext.containerView()?.addSubview(presentedView)
        // 执行动画
        presentedView.transform = CGAffineTransformMakeScale(1.0, 0.0)
        // 设置锚点
        presentedView.layer.anchorPoint = CGPointMake(0.5, 0)
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            // 回复原来状态
            presentedView.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                // 告知上下文已经完成动画
                transitionContext.completeTransition(true)
        }
    }
    
    // MARK:- 自定义消失动画
    private func animationForDismissView(transitionContext: UIViewControllerContextTransitioning) {
        // 获取消失 view
        let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        // 执行动画
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            dismissView.transform = CGAffineTransformMakeScale(1.0, 0.0001)
            }) { (_) -> Void in
                dismissView.removeFromSuperview()
                // 告知上下文已经完成动画
                transitionContext.completeTransition(true)
        }
    }
}