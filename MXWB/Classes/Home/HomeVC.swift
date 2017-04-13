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

    override func viewDidLoad()
    {
        super.viewDidLoad()
        if !hasLogin {
            visitorView?.setupViews(imageName: nil, title: "关注一些人去～")
//            return
        }
        
        setupNav()
    }
    
    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationbar_friendattention"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeVC.leftBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationbar_pop"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeVC.rightBtnClick))
        
        let titleButton = TitleButton()
        titleButton.setTitle("xxx", for: UIControlState.normal)
        titleButton.addTarget(self, action: #selector(HomeVC.titleBtnClick(titleButton:)), for: UIControlEvents.touchUpInside)
        navigationItem.titleView = titleButton

    }
    
    @objc private func titleBtnClick(titleButton: TitleButton) {
        
        let popSB = UIStoryboard.init(name: "Popover", bundle: nil)
        guard let menuVC = popSB.instantiateInitialViewController() else {
            return
        }
        menuVC.transitioningDelegate = self
        menuVC.modalPresentationStyle = UIModalPresentationStyle.custom
        present(menuVC, animated: true, completion: nil)
    }
    
    @objc private func leftBtnClick() {
        
    }
    
    @objc private func rightBtnClick() {
        
    }

}

extension HomeVC: UIViewControllerTransitioningDelegate
{
    // 返回一个负责转场动画的对象
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MXPresentationC.init(presentedViewController: presented, presenting: source)
    }
}
