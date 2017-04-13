//
//  MXPresentationC.swift
//  MXWB
//
//  Created by maRk on 2017/4/13.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class MXPresentationC: UIPresentationController {
    /*
     1.如果不自定义转场modal出来的控制器会移除原有的控制器
     2.如果自定义转场modal出来的控制器不会移除原有的控制器
     3.如果不自定义转场modal出来的控制器的尺寸和屏幕一样
     4.如果自定义转场modal出来的控制器的尺寸我们可以自己在containerViewWillLayoutSubviews方法中控制
     5.containerView 非常重要, 容器视图, 所有modal出来的视图都是添加到containerView上的
     6.presentedView() 非常重要, 通过该方法能够拿到弹出的视图
     */
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentedViewController)
    }
    
    // 用于布局转场动画弹出的控件
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = CGRect.init(x: 100, y: 45, width: 200, height: 200)
        containerView?.addSubview(coverBtn)
    }
    
    lazy var coverBtn = { () -> UIButton in 
        let coverBtn = UIButton()
        coverBtn.frame = UIScreen.main.bounds
        coverBtn.addTarget(self, action: #selector(MXPresentationC.coverBtnClick(coverBtn:)), for: UIControlEvents.touchUpInside)
        return coverBtn
    }()
    
    @objc private func coverBtnClick(coverBtn: UIButton) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
