//
//  ViewController.swift
//  mxwb
//
//  Created by maRk on 17/3/31.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeVC: BaseTableVC
{
    //MARK: LazyLoad
    private lazy var transitionMg = { () -> MXTransitionManager in
        let transitionMg = MXTransitionManager()
        transitionMg.presentViewFrame = CGRect(x: 100, y: 45, width: 200, height: 300)
        return transitionMg
    }()
    
    private lazy var titleBtn = { () -> TitleButton in
        let titleBtn = TitleButton()
        titleBtn.setTitle("mark", for: UIControlState.normal)
        return titleBtn
    }()
    
    var statusArray: [StatusViewModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if !hasLogin {
            visitorView?.setupViews(imageName: nil, title: "关注一些人去～")
            return
        }
        setupNav()
        addNotification()
        getHomeData()
        registerCell()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: PrivateFunc
    private func addNotification()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeVC.menuDidPresented), name: NSNotification.Name(rawValue: MXWB_NOTIFICATION_TRANSITIONMANAGER_DIDPRESENTED), object: transitionMg)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeVC.menuDidDismissed), name: NSNotification.Name(rawValue: MXWB_NOTIFICATION_TRANSITIONMANAGER_DIDDISMISSED), object: transitionMg)

    }
    
    private func setupNav()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationbar_friendattention"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeVC.leftBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationbar_pop"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeVC.rightBtnClick))
        
        
        navigationItem.titleView = titleBtn
        titleBtn.addTarget(self, action: #selector(HomeVC.titleBtnClick(titleButton:)), for: UIControlEvents.touchUpInside)

    }
    
    /// 记得使用xib前一定要注册
    private func registerCell()
    {
        let cellnNib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(cellnNib, forCellReuseIdentifier: "HomeTableViewCell")
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
    
    /// 获取微博数据
    func getHomeData()
    {
        HttpManager.sharedManager.getHomeStatus { (statusArray: [[String: Any]]?, error: Error?) in
            if error != nil {
                SVProgressHUD.showError(withStatus: "获取微博数据失败")
            }
            
            // 判断微博数组是否为空
            guard let statusArr = statusArray else {
                return
            }
            
            // 创建数组，要有()才代表创建
            var statusVMArray = [StatusViewModel]()
            // 将转换后的vm模型存入数组
            for statusDic in statusArr {
                let statusModel = StatusModel(dics: statusDic)
                let statusViewModel = StatusViewModel(status: statusModel)
                statusVMArray.append(statusViewModel)
            }
            self.statusArray = statusVMArray
        }
    }
}

extension HomeVC
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.statusArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        cell.statusViewMoldel = self.statusArray?[indexPath.row]
        
        return cell
    }
}



