//
//  StatusModel.swift
//  MXWB
//
//  Created by maRk on 2017/4/22.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class StatusModel: NSObject {
    /// 微博创建时间
    var created_at: String?
    /// 字符串型的微博Id
    var idstr: String?
    /// 来源
    var source: String?
    /// 用户
    var user: UserModel?
    /// 内容
    var text: String?
    /// 配图数组
    var pic_urls: [[String: Any]]?
    

    init(dics: [String: Any]) {
        super.init()
        setValuesForKeys(dics)
    }
    
    override func setValue(_ value: Any?, forKey key: String)
    {
        // 如果是user，则需要在内部再转换一次
        if key == "user" {
            user = UserModel(dict: value as! [String: Any])
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    /// 重写description
    override var description: String {
        let properties = ["created_at", "idstr", "source", "user"]
        let dics = dictionaryWithValues(forKeys: properties)
        return "\(dics)"
    }
}
