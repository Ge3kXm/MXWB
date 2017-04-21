//
//  TabBarVC.swift
//  mxwb
//
//  Created by maRk on 17/3/31.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.orange
        
        addVCs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.addSubview(midButton)
        
        let oriRect = midButton.frame
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count)
        
        midButton.frame = CGRect(x: 2 * width, y: 0, width: width, height: oriRect.height)
    }
    

    // MARK: - PrivateFunc
    func addVCs()
    {
        let filePath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil)!
        
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        
        do {
            let jsonDics = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
            for dic in jsonDics {
                let name = dic["vcName"] as? String
                let title = dic["title"] as? String
                let image = dic["imageName"] as? String
                addChildViewControllers(childVCName: name, title: title, image: image)
            }
        }
        catch {
            addChildViewControllers(childVCName: "HomeVC", title: "首页", image: "tabbar_home")
            addChildViewControllers(childVCName: "MessageVC", title: "消息", image: "tabbar_message_center")
            addChildViewControllers(childVCName: "NullVC", title: "", image: "")
            addChildViewControllers(childVCName: "DiscoverVC", title: "发现", image: "tabbar_discover")
            addChildViewControllers(childVCName: "MeVC", title: "我", image: "tabbar_profile")
        }
    
    }
    
    func addChildViewControllers(childVCName: String?, title: String?, image: String?)
    {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        MXLog(namespace)
        
        var cls: AnyClass? = nil
        if let vcName = childVCName {
            cls = NSClassFromString(namespace + "." + vcName)
        }
        
        guard let vcCls = cls as? UITableViewController.Type else {
            MXLog("vcCls is not UItTableViewController")
            return
        }
        
        let childVC = vcCls.init()
    
        childVC.title = title
        
        if let vcImage = image {
            childVC.tabBarItem.image = UIImage(named: vcImage)
            childVC.tabBarItem.selectedImage = UIImage(named: vcImage)
        }
        
        let nav = UINavigationController(rootViewController: childVC)
        addChildViewController(nav)
    }
    
    @objc func addButtonClick(addButton: UIButton) {
        MXLog(addButton)
    }
    
    // MARK: - Lazy load
    lazy var midButton = {
        () -> UIButton
        in
        let midButton = UIButton(imageName: "", backgroundImage: "")
        
        midButton.addTarget(self, action: Selector(("addButtonClick:")), for: UIControlEvents.touchUpInside)


        return midButton
    }()
    
}
