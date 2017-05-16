//
//  HomeRefreshView.swift
//  MXWB
//
//  Created by maRk on 2017/5/15.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit
import SnapKit

class HomeRefreshView: UIRefreshControl {
    var refreshView = RefreshView.refreshView()
    
    override init() {
        super.init()
        // 添加子控件
        addSubview(refreshView)
        // 布局子控件
        refreshView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 150, height: 50))
            make.center.equalTo(self)
        // kvc监听frame改变
        addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.new, context: nil)
        }
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        refreshView.stopAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 旋转标记，保证旋转一次
    var rotationFlag = false
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        MXLog(object)
        
        if frame.height == 0 || frame.height == -60 {
            return
        }
        
        if isRefreshing {
            refreshView.startAnimation()
            return
        }
        
        if frame.origin.y < -64 && !rotationFlag {
            rotationFlag = true
            refreshView.rotateArrow(flag: rotationFlag)
        }else if frame.origin.y > -64 && rotationFlag {
            rotationFlag = false
            refreshView.rotateArrow(flag: rotationFlag)
        }
    }
    
    
    func stopLoading() {
        endRefreshing()
        refreshView.stopAnimation()
    }
    
}

class RefreshView: UIView {

    @IBOutlet weak var arrowView: UIImageView!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var loadingView: UIImageView!
    
    // 类方法
    class func refreshView() -> RefreshView {
        return Bundle.main.loadNibNamed("RefreshView", owner: nil, options: nil)?.last! as! RefreshView
    }
    
    // 箭头旋转
    func rotateArrow(flag: Bool) {
        var angle = flag ? -0.01 : 0.01
        angle += Double.pi
        
        UIView.animate(withDuration: 1) {
            self.arrowView.transform = self.arrowView.transform.rotated(by: CGFloat(angle))
        }
    }
    
    // 开始旋转动画
    func startAnimation() {
        tipView.isHidden = true
        
        // 根据key获取判断是否正在动画
        if let _ = loadingView.layer.animation(forKey: "rotation") {
            return
        }
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.duration = 5.0
        animation.toValue = 2 * Double.pi
        animation.repeatCount = MAXFLOAT
        
        loadingView.layer.add(animation, forKey: "rotation")
    }

    // 结束旋转动画
    func stopAnimation() {
        tipView.isHidden = false
        loadingView.layer.removeAllAnimations()
    }
}
