//
//  MXProgressImageView.swift
//  MXWB
//
//  Created by maRk on 2017/5/16.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class MXProgressImageView: UIImageView {
    
    var progress: CGFloat = 0.0 {
        didSet {
            progressView.progress = progress
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
    func initUI() {
        addSubview(progressView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressView.frame = bounds
    }
    
    lazy var progressView: MXProgressView = {
        let progressView = MXProgressView()
        progressView.backgroundColor = UIColor.clear
        return progressView
    }()

}

class MXProgressView: UIView {
    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
            MXLog("setNeedDisplay")
        }
    }
    
    override func draw(_ rect: CGRect) {
        MXLog(rect)
    }
    
//    override func draw(_ rect: CGRect) {
//        MXLog(progress)
//        let radius = min(rect.size.height, rect.size.width)
//        
//        let startAngle = CGFloat(-Double.pi) * 0.5
//        let endAngle = CGFloat(Double.pi) * 2 * progress + startAngle
//        // 设置曲线
//        let bPath = UIBezierPath(arcCenter: center, radius: 20, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//        bPath.addLine(to: center)
//        bPath.close()
//        UIColor.red.setFill()
//        bPath.fill()
//    }
    
}
