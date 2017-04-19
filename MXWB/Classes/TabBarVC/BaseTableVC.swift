//
//  BaseTableVC.swift
//  mxwb
//
//  Created by maRk on 2017/4/12.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class BaseTableVC: UITableViewController {

    var hasLogin = OAuthAccount.hasLogin()
    
    var visitorView: VisitorView?
    
    override func loadView() {
        hasLogin ? super.loadView() : setupView()
    }
    
    func setupView() {
        visitorView = VisitorView.visitorView()
        view = visitorView
        
        visitorView?.registBtn.addTarget(self, action: #selector((BaseTableVC.registBtnClick(registBtn:))), for: UIControlEvents.touchUpInside)
        visitorView?.loginBtn.addTarget(self, action: #selector(BaseTableVC.loginBtnClick(login:)), for: UIControlEvents.touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseTableVC.registBtnClick(registBtn:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseTableVC.loginBtnClick(login:)))
    }
    
    @objc private func registBtnClick(registBtn: UIButton) {
        MXLog(registBtn)
    }
    
    @objc private func loginBtnClick(login: UIButton) {
        MXLog(login)
//        navigationController?.pushViewController(OAuthVC(), animated: true)
        present(OAuthVC(), animated: true, completion: nil)
    }
}
