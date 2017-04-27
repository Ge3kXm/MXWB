//
//  QRCodeVC.swift
//  MXWB
//
//  Created by maRk'sTheme on 2017/4/14.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class QRCodeVC: UIViewController {

    @IBOutlet weak var closeBtn: UIBarButtonItem!
    @IBOutlet weak var photoAlbumBtn: UIBarButtonItem!
    @IBOutlet weak var tabbar: UITabBar!
    @IBOutlet weak var qrScanTopCons: NSLayoutConstraint!
    @IBOutlet weak var qrCtScanHeightCons: NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        startAnimation()
    }

    func startAnimation()
    {
        qrScanTopCons.constant = -qrCtScanHeightCons.constant
        // 强制刷新
        view.layoutIfNeeded()
        
        // 通过修改约束来实现动画
        UIView.animate(withDuration: 2.0, animations: {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.qrScanTopCons.constant = self.qrCtScanHeightCons.constant
            // 强制刷新
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func closeBtnClick(sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
}

extension QRCodeVC: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {
        qrCtScanHeightCons.constant = item.tag == 0 ? 150 : 150
        view.layoutIfNeeded()
        
        view.layer.removeAllAnimations()
        
        startAnimation()
    }
}
