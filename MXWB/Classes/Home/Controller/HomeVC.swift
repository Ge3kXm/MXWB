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
    //MARK: - LazyLoad
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
    
    // 记录当前是否为最后一条weibo
    lazy var lastFlag = false
    
    var statusListModel = StatusListModel()
    
    var cellHeightCache = [String: CGFloat]()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if !hasLogin {
            visitorView?.setupViews(imageName: nil, title: "关注一些人去～")
            return
        }
        initUI()
        setupNav()
        addNotification()
        loadData(lastFlag)
        registerCell()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - PrivateFunc
    private func addNotification()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeVC.menuDidPresented), name: NSNotification.Name(rawValue: MXWB_NOTIFICATION_TRANSITIONMANAGER_DIDPRESENTED), object: transitionMg)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeVC.menuDidDismissed), name: NSNotification.Name(rawValue: MXWB_NOTIFICATION_TRANSITIONMANAGER_DIDDISMISSED), object: transitionMg)

    }
    
    private func initUI()
    {
        tableView.estimatedRowHeight = 400
        
        // 继承自tableVC都带此属性
        refreshControl = HomeRefreshView()
        refreshControl?.addTarget(self, action: #selector(HomeVC.loadData), for: UIControlEvents.valueChanged)
        refreshControl?.beginRefreshing()
        
//        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
//        tableView.rowHeight = UITableViewAutomaticDimension
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
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.register(UINib(nibName: "HomeForwardCell", bundle: nil), forCellReuseIdentifier: "HomeForwardCell")
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
    
    func loadData(_ lastFlag: Bool) {
        statusListModel.loadData(isLast: lastFlag) { (statusVMArray, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: "获取微博数据失败", maskType: SVProgressHUDMaskType.black)
                return
            }
            
            self.refreshControl?.endRefreshing()
            
            self.tableView.reloadData()
        }
    }
    
}

extension HomeVC
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.statusListModel.statusArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let statusVM = statusListModel.statusArray![indexPath.row]
        // 先从缓存中取高度
        guard let cacheHeight = cellHeightCache[statusVM.status.idstr ?? "-1"] else {
            // 缓存没有高度则重新计算高度
            if statusVM.forward_Text != nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeForwardCell") as! HomeForwardCell
                let cellHeight = cell.calculateCellHeight(statusVM: statusVM)
                
                cellHeightCache[statusVM.status.idstr ?? "-1"] = cellHeight
                return cellHeight
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
                let cellHeight = cell.calculateCellHeight(statusVM: statusVM)
                
                cellHeightCache[statusVM.status.idstr ?? "-1"] = cellHeight
                return cellHeight
            }
        }
        return cacheHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let statusVM = statusListModel.statusArray![indexPath.row]
        
        // 有转发的
        if statusVM.forward_Text != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeForwardCell") as! HomeForwardCell
            cell.statusViewMoldel = self.statusListModel.statusArray?[indexPath.row]
            if indexPath.row == statusListModel.statusArray!.count - 1 {
                lastFlag = true
                loadData(lastFlag)
            }
            return cell
        // 没有转发
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
            cell.statusViewMoldel = self.statusListModel.statusArray?[indexPath.row]
            if indexPath.row == statusListModel.statusArray!.count - 1 {
                lastFlag = true
                loadData(lastFlag)
            }
            return cell
        }
    }
}



