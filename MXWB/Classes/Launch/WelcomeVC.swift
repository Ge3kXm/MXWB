//
//  WelcomeVC.swift
//  MXWB
//
//  Created by maRk on 2017/4/20.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad()
    {
       super.viewDidLoad()
       initUI()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: Notification.Name(MXWB_NOTIFICATION_SWITCHROOTVC_KEY), object: true)
    }
    
    private func initUI()
    {
        iconView.layer.cornerRadius = 50
        iconView.layer.masksToBounds = true
    }
    
    /// 通过改变约束实现动画
    private func startAnimation()
    {
        UIView.animate(withDuration: 2.0, animations: {
            self.bottomLayout.constant = UIScreen.main.bounds.height - self.bottomLayout.constant
            self.view.layoutIfNeeded()
        }, completion: {
            (_) -> Void in
            
            UIView.animate(withDuration: 1.0, animations: {
                self.titleLabel.alpha = 1.0
            }, completion: { (_) in
            })
        })
    }
}
