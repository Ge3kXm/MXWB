//
//  HttpManager.swift
//  MXWB
//
//  Created by maRk on 2017/4/18.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit
import AFNetworking

class HttpManager: AFHTTPSessionManager {
    /// 单例
    static let sharedManager: HttpManager =
    {
        let baseUrl = URL(string: "https://api.weibo.com/")
        let instance = HttpManager(baseURL: baseUrl, sessionConfiguration: URLSessionConfiguration.default)
        instance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set
        return instance
    }()
    
    /// 获取首页微博数据
    func getHomeStatus(finished: (_ success: [[String: Any]]?, _ error: Error?) -> ())
    {
        
    }

}
