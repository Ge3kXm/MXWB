//
//  OAuthAccount.swift
//  MXWB
//
//  Created by maRk on 2017/4/18.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class OAuthAccount: NSObject {
    
    var access_token: String?
    var expires_in: Int = 0
    var uid: String?
    
    init(dict: [String: Any]) {
        // 如果要想初始化方法中使用KVC必须先调用super.init初始化对象
        // 如果属性是基本数据类型, 那么建议不要使用可选类型, 因为基本数据类型的可选类型在super.init()方法中不会分配存储空间
        super.init()
        setValuesForKeys(dict)
    }
}
