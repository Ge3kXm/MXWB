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
    
    /// 获取首页微博数据r
    func getHomeStatus(sinceId: String, maxId: String, finished: @escaping (_ success: [[String: Any]]?, _ error: Error?) -> ())
    {
        let path = "2/statuses/home_timeline.json"
        let maxId = (maxId != "0") ? "\(Int(maxId)! - 1)" : "0"
        
        let parameters = ["access_token": OAuthAccount.getAccount()?.access_token!,
                              "since_id": sinceId,
                                "max_id": maxId ]
        
        get(path, parameters: parameters, progress: nil, success: { (taks, objs) in
            let obj = objs as! [String : Any]
            
            guard let status = obj["statuses"] as? [[String: Any]] else {
                let error = NSError(domain: "www.google.com", code: -0, userInfo: ["message": "没有数据"])
                finished(nil, error)
                return
            }
            
            finished(status, nil)
        }) { (task, error) in
            finished(nil, error)
        }
    }

}
