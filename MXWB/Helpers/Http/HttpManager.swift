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
    static let sharedManager :HttpManager = {
        let baseUrl = URL(string: "https://api.weibo.com/")
        let instance = HttpManager(baseURL: baseUrl, sessionConfiguration: URLSessionConfiguration.default)
        instance.responseSerializer.acceptableContentTypes = NSSet(object: "text/plain") as? Set
        return instance
    }()

}