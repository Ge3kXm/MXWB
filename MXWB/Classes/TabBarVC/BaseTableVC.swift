//
//  BaseTableVC.swift
//  mxwb
//
//  Created by maRk on 2017/4/12.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class BaseTableVC: UITableViewController {

    var hasLogin = false
    
    var visitorView: VisitorView?
    
    override func loadView() {
        hasLogin ? super.loadView() : setupView()
    }
    
    func setupView() {
        visitorView = VisitorView.visitorView()
        view = visitorView
        
        visitorView?.registBtn.addTarget(self, action: Selector(("registBtnClick:")), for: UIControlEvents.touchUpInside)
        visitorView?.registBtn.addTarget(self, action: Selector(("loginBtnClick:")), for: UIControlEvents.touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("registerBtnClick:")))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("loginBtnClick:")))
    }
    
    @objc func registBtnClick(registBtn: UIButton) {
        MXLog(registBtn)
    }
    
    @objc func loginBtnClick(login: UIButton) {
        MXLog(login)
    }
}
