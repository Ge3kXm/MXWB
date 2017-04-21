//
//  OAuthAccount.swift
//  MXWB
//
//  Created by maRk on 2017/4/18.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class OAuthAccount: NSObject, NSCoding {
    
    var access_token: String?
    var expires_in: Int = 0
    {
        // 重写set方法
        didSet {
            expires_date = Date(timeIntervalSinceNow: TimeInterval(expires_in))
        }
    }
    var uid: Int = 0
    var expires_date: Date?
    
    var userId: String?
    var avatar_large: String?
    var screen_name: String?
    
    // 静态成员变量
    static var oAuthAccount: OAuthAccount?
    static let filePath = "oAtuthAccount.plist".cacheDir()
    
    init(dict: [String: Any])
    {
        // 如果要想初始化方法中使用KVC必须先调用super.init初始化对象
        // 如果属性是基本数据类型, 那么建议不要使用可选类型, 因为基本数据类型的可选类型在super.init()方法中不会分配存储空间
        super.init()
        setValuesForKeys(dict)
    }
    
    //MARK: - privateFunc
    /// 找不到key时调用
    override func setValue(_ value: Any?, forUndefinedKey key: String)
    {
        
    }
    
    func getUserInfo(finished: @escaping (_ account: OAuthAccount?, _ error: Error?) -> ())
    {
        assert(access_token != nil, "必须授权后才能获取用户信息")
        
        let path = "2/users/show.json"
        let parameters = ["access_token": access_token!, "uid": uid] as [String : Any]
        
        HttpManager.sharedManager.get(path, parameters: parameters, progress: nil, success: { (task, obj) in
            let userInfoDic = obj as! [String: Any]
            self.avatar_large = userInfoDic["avatar_large"] as? String
            self.userId = userInfoDic["userId"] as? String
            self.screen_name = userInfoDic["screen_name"] as? String
            
            MXLog(obj)
            finished(self, nil)
        }) { (task, error) in
            MXLog(error)
            finished(self, error)
        }
        
    }
    
    /// 重写description
    override var description: String {
        // 将模型转换为字典
        let property = ["access_token", "expires_in", "uid", "expires_date", "userId", "avatar_large", "screen_name"]
        let dict = dictionaryWithValues(forKeys: property)
        // 将字典转换为字符串
        return "\(dict)"
    }
    
    /// 保存token
    func saveAccount() -> Bool{
        return NSKeyedArchiver.archiveRootObject(self, toFile: OAuthAccount.filePath)
    }
    
    /// 获取token
    class func getAccount() -> OAuthAccount? {
        if OAuthAccount.oAuthAccount != nil {
            // 已经加载过
            return OAuthAccount.oAuthAccount
        }
        
        guard let account = NSKeyedUnarchiver.unarchiveObject(withFile: OAuthAccount.filePath) as? OAuthAccount else {
            return nil
        }
        
        guard let date = account.expires_date, date.compare(Date()) != ComparisonResult.orderedAscending else {
            MXLog("过期了")
            return nil
        }
        OAuthAccount.oAuthAccount = account
        return OAuthAccount.oAuthAccount
    }
    
    /// 
    
    
    
    /// 判断是否已经登录
    class func hasLogin() -> Bool {
        return OAuthAccount.getAccount() != nil
    }
    
    // MARK: - NSCoding协议
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String
//        self.expires_in =  aDecoder.decodeObject(forKey: "expires_in") as! Int
        self.expires_in = 157679999
//        self.uid =  aDecoder.decodeObject(forKey: "uid") as! Int
        self.uid = 2651026543
        self.expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        self.avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        self.userId = aDecoder.decodeObject(forKey: "userId") as? String
        self.screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    }
}
