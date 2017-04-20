//
//  NewFeatureVC.swift
//  MXWB
//
//  Created by maRk on 2017/4/20.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class NewFeatureVC: UIViewController {

    lazy var bgImageView: UIImageView = {
        let bgView = UIImageView(frame: UIScreen.main.bounds)
        bgView.image = UIImage(named: "new_feature_1")
        return bgView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: UIButtonType.contactAdd)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.addTarget(self, action: #selector(NewFeatureVC.startClick), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    @objc func startClick()
    {
        NotificationCenter.default.post(name: NSNotification.Name(MXWB_NOTIFICATION_SWITCHROOTVC_KEY), object: true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initUI()
    }

    private func initUI()
    {
        view.addSubview(bgImageView)
        view.addSubview(button)
    }

}
