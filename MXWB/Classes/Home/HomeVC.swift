//
//  ViewController.swift
//  mxwb
//
//  Created by maRk on 17/3/31.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class HomeVC: BaseTableVC
{
    private lazy var transitionMg = { () -> MXTransitionManager in
        let transitionMg = MXTransitionManager()
        transitionMg.presentViewFrame = CGRect(x: 100, y: 45, width: 200, height: 300)
        return transitionMg
    }()
    
    private lazy var titleBtn = { () -> TitleButton in
        let titleBtn = TitleButton()
        titleBtn.setTitle("xxx", for: UIControlState.normal)
        return titleBtn
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if !hasLogin {
            visitorView?.setupViews(imageName: nil, title: "关注一些人去～")
//            return
        }
        setupNav()
        addNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addNotification()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeVC.menuDidPresented), name: NSNotification.Name(rawValue: MXWB_NOTIFICATION_TRANSITIONMANAGER_DIDPRESENTED), object: transitionMg)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeVC.menuDidDismissed), name: NSNotification.Name(rawValue: MXWB_NOTIFICATION_TRANSITIONMANAGER_DIDDISMISSED), object: transitionMg)

    }
    
    // MARK: - 
    private func setupNav()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationbar_friendattention"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeVC.leftBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationbar_pop"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeVC.rightBtnClick))
        
        
        navigationItem.titleView = titleBtn
        titleBtn.addTarget(self, action: #selector(HomeVC.titleBtnClick(titleButton:)), for: UIControlEvents.touchUpInside)

    }
    
    @objc private func titleBtnClick(titleButton: TitleButton)
    {
        let popSB = UIStoryboard(name: "Popover", bundle: nil)
        guard let menuVC = popSB.instantiateInitialViewController() else {
            return
        }
        menuVC.transitioningDelegate = transitionMg
        menuVC.modalPresentationStyle = UIModalPresentationStyle.custom
        present(menuVC, animated: true, completion: nil)
    }
    
    @objc private func leftBtnClick()
    {
        
    }
    
    @objc private func rightBtnClick()
    {
        let QRCodeSB = UIStoryboard(name: "QRCode", bundle: nil)
        guard let QRCodeVC = QRCodeSB.instantiateInitialViewController() else {
            return
        }
        
        present(QRCodeVC, animated: true, completion: nil)
        
    }
    
    @objc private func menuDidPresented()
    {
        titleBtn.isSelected = true
    }

    @objc private func menuDidDismissed()
    {
        titleBtn.isSelected = false
    }
}



