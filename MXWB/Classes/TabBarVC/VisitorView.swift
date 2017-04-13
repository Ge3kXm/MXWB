//
//  VisitorView.swift
//  mxwb
//
//  Created by maRk on 2017/4/12.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var rotateView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var desView: UILabel!
    
    class func visitorView() -> VisitorView{
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)!.last as! VisitorView
    }
    
    func setupViews(imageName: String?, title : String) {
        desView.text = title
        // Not homepage
        guard let name = imageName else {
            startAnimation()
            return
        }
        
        rotateView.isHidden = true
        iconView.image = UIImage(named: name)
        
    }
    
    func startAnimation() {
        let anim = CABasicAnimation()
        
        anim.toValue = Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 5
        anim.isRemovedOnCompletion = false
        
        rotateView.layer.add(anim, forKey: "transform.rotation")
    }

}
