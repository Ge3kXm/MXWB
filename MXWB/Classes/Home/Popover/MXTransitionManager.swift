//
//  MXTransitionManager.swift
//  MXWB
//
//  Created by maRk'sTheme on 2017/4/14.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class MXTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    // 标志，为了判断转场动画中的fromView，和toView
    var isPresented = false
    // 存放presnetView的frame
    var presentViewFrame: CGRect?
    
    
    // MARK: -- UIViewControllerTransitioningDelegate
    // 返回一个负责转场动画的对象
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        let pc = MXTransitionController(presentedViewController: presented, presenting: source)
        pc.presentedViewFrame = presentViewFrame
        return pc
    }
    
    // 返回一个管理弹出的对象
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: MXWB_NOTIFICATION_TRANSITIONMANAGER_DIDPRESENTED), object: self)
        isPresented = true
        return self
    }
    
    // 返回一个管理消失的对象
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: MXWB_NOTIFICATION_TRANSITIONMANAGER_DIDDISMISSED), object: self)
        isPresented = false
        return self
    }
    
    // MARK: -- UIViewControllerAnimatedTransitioning
    // 动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.25
    }
    
    // 实现该方法，系统就不会出现默认的转场动画，所有动画都需要自己实现，所有的东西都在transitionContext中
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresented {
            willPresentController(transitionContext: transitionContext)
        }else {
            willDismissController(transitionContext: transitionContext)
        }
    
    }
    
    private func willPresentController(transitionContext: UIViewControllerContextTransitioning)
    {
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        // 动画实现菜单的弹出
        toView.transform = CGAffineTransform(scaleX: 1.0, y: 0)
        toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.transform = CGAffineTransform.identity
        }) { (_) in
            // 完成动画后必须要调用该方法
            transitionContext.completeTransition(true)
        }
    }
    
    private func willDismissController(transitionContext: UIViewControllerContextTransitioning)
    {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
        
        fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001)
        }, completion: { (_) in
            fromView.removeFromSuperview()
            // 完成动画后必须要调用该方法
            transitionContext.completeTransition(true)
        })
    }
}
