//
//  UserModel.swift
//  MXWB
//
//  Created by maRk on 2017/4/22.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    /// 字符串型的用户UID
    var idstr: String?
    /// 用户昵称
    var screen_name: String?
    /// 用户头像字符串地址（中图），50×50像素
    var profile_image_url: String?
    /// 用户认证类型 -1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var verified_type: Int = -1
    /// 会员等级 ,取值范围 1~6
    var mbrank: Int = -1
    
    init(dict: [String: Any])
    {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String
    {
        let properties = ["idstr", "screen_name", "profile_image_url", "verified_type", "mbrank"]
        let dict = dictionaryWithValues(forKeys: properties)
        return "\(dict)"
    }
}
