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
    var uid: String?
    
    init(dict: [String: Any])
    {
        // 如果要想初始化方法中使用KVC必须先调用super.init初始化对象
        // 如果属性是基本数据类型, 那么建议不要使用可选类型, 因为基本数据类型的可选类型在super.init()方法中不会分配存储空间
        super.init()
        setValuesForKeys(dict)
    }
    
    /// 找不到key时调用
    override func setValue(_ value: Any?, forUndefinedKey key: String)
    {
        
    }
    
    /// 重写description
    override var description: String {
        // 将模型转换为字典
        let property = ["access_token", "expires_in", "uid"]
        let dict = dictionaryWithValues(forKeys: property)
        // 将字典转换为字符串
        return "\(dict)"
    }
    
    static var oAuthAccount: OAuthAccount?
    static let filePath = "oAtuthAccount.cache".cacheDir()
    
    /// 保存token
    func saveAccount() -> Bool{
        return NSKeyedArchiver.archiveRootObject(self, toFile: OAuthAccount.filePath)
    }
    
    /// 获取token
    func getAccount() -> OAuthAccount? {
        if OAuthAccount.oAuthAccount != nil {
            // 已经加载过
            return OAuthAccount.oAuthAccount
        }
        
        guard let account = NSKeyedUnarchiver.unarchiveObject(withFile: OAuthAccount.filePath) as? OAuthAccount else {
            return OAuthAccount.oAuthAccount
        }
        OAuthAccount.oAuthAccount = account
        return OAuthAccount.oAuthAccount
    }
    
    /// 判断是否已经登录
    func hasLogin() -> Bool {
        return OAuthAccount.oAuthAccount != nil
    }
    
    // MARK: NSCoding协议
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(uid, forKey: "uid")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        self.expires_in =  aDecoder.decodeObject(forKey: "expires_in") as! Int
        self.uid =  aDecoder.decodeObject(forKey: "uid") as? String
    }
}
