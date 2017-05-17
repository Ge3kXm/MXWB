//
//  MXBrowserPC.swift
//  MXWB
//
//  Created by maRk on 2017/5/17.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

protocol MXPicBrowserDelegate: NSObjectProtocol {
    // 被点击图片原大小的图片
    func browserPresentionShowImageView(presentationController: MXPicBrowserPC, indexPath: IndexPath) -> UIImageView
    // 被点击图片相对于window的frame
    func browserPresentionFromFrame(presentationController: MXPicBrowserPC, indexPath: IndexPath) -> CGRect
    // 被点击图片放大后的frame
    func browserPresentionToFrame(presentationController: MXPicBrowserPC, indexPath: IndexPath) -> CGRect
}

class MXPicBrowserPC: UIPresentationController {
    // 记录当前是否显示
    var isPresented = false
    // 代理
    weak var browserDelegate: MXPicBrowserDelegate?
    // 当前点击的indexPath
    var indexPath: IndexPath?
    
    func setDelegateAndIndexPath(browserDelegate: MXPicBrowserDelegate, indexPath: IndexPath) {
        self.browserDelegate = browserDelegate
        self.indexPath = indexPath
    }
}

extension MXPicBrowserPC: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MXPicBrowserPC(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}

extension MXPicBrowserPC: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresented {
            willPresentController(transitionContext: transitionContext)
        }else {
            willDismissController(transitionContext: transitionContext)
        }
    }
    
    // 显示动画
    private func willPresentController(transitionContext: UIViewControllerContextTransitioning)
    {
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        
        let iv = browserDelegate!.browserPresentionShowImageView(presentationController: self, indexPath: indexPath!)
        let fromeFrame = browserDelegate!.browserPresentionFromFrame(presentationController: self, indexPath: indexPath!)
        iv.frame = fromeFrame
        let toFrame = browserDelegate!.browserPresentionToFrame(presentationController: self, indexPath: indexPath!)
        
        
        let containerView = transitionContext.containerView
        containerView.addSubview(iv)
        
        UIView.animate(withDuration: 2, animations: {
            iv.frame = toFrame
        }) { (_) in
            iv.removeFromSuperview()
            containerView.addSubview(toView)
            transitionContext.completeTransition(true)
        }
        
    }
    
    // 消失动画
    private func willDismissController(transitionContext: UIViewControllerContextTransitioning)
    {
//        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
//            return
//        }
        
    }
}
