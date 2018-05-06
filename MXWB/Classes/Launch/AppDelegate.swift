//
//  AppDelegate.swift
//  mxwb
//
//  Created by maRk on 17/3/31.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        let path = Bundle.main.path(forResource: "moments", ofType: "mp4")

        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = UIColor.white
        window?.rootViewController = getDefaultVC()
        window?.makeKeyAndVisible()
        registNotification()
        MXLog(OAuthAccount.getAccount())
        
        UINavigationBar.appearance().tintColor = UIColor.orange
        return true
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }

}

extension AppDelegate
{
    /// 注册通知
    func registNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(switchRootVC(noti:)), name: NSNotification.Name(rawValue: MXWB_NOTIFICATION_SWITCHROOTVC_KEY), object: nil)
    }
    
    /// 切换根控制器
    func switchRootVC(noti: Notification) {
        if noti.object as! Bool {
            window?.rootViewController = TabBarVC()
        }else {
            window?.rootViewController = WelcomeVC()
        }
    }
    
    /// 判断是否为新版
    func hasNewFeature() -> Bool {
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let oldVersion = "0.0"
        if currentVersion.compare(oldVersion) == ComparisonResult.orderedAscending {
            MXLog("有新版本")
            UserDefaults.standard.set(currentVersion, forKey: "oldVersion")
            return true
        }
        return false
    }
    
    /// 获取默认根控制器
    func getDefaultVC() -> UIViewController {
        // 已经登录
        if OAuthAccount.hasLogin() {
            if hasNewFeature() {
                return NewFeatureVC()
            }else {
                let sb = UIStoryboard(name: "WelcomeVC", bundle: nil)
                let welcomeVC = sb.instantiateInitialViewController()!
                return welcomeVC
            }
            // 未登录
        }else {
            return TabBarVC()
        }
    }
}


