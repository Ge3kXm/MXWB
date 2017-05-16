//
//  StatusListModel.swift
//  MXWB
//
//  Created by maRk on 2017/5/16.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class StatusListModel: NSObject {
    var statusArray: [StatusViewModel]?
    
    /// 获取微博数据
    func loadData(isLast: Bool, finish: @escaping (_ status: [StatusViewModel]?, _ error: Error?) -> Void)
    {
        // 获取最新一条数据Id
        var sinceId = statusArray?.first?.status.idstr ?? "0"
        // 获取最早一条数据Id
        var maxId = "0"
        // 是最后一条
        if isLast {
            sinceId = "0"
            maxId = statusArray?.last?.status.idstr ?? "0"
        }
        
        HttpManager.sharedManager.getHomeStatus(sinceId: sinceId, maxId: maxId) { (statusArray: [[String: Any]]?, error: Error?) in
            if error != nil {
                SVProgressHUD.showError(withStatus: "获取微博数据失败")
                finish(nil, error)
            }
            
            // 判断微博数组是否为空
            guard let statusArr = statusArray else {
                return
            }
            
            // 创建数组，要有()才代表创建
            var statusVMArray = [StatusViewModel]()
            // 将转换后的vm模型存入数组
            for statusDic in statusArr {
                let statusModel = StatusModel(dics: statusDic)
                let statusViewModel = StatusViewModel(status: statusModel)
                statusVMArray.append(statusViewModel)
            }
            
            // 请求最新
            if sinceId != "0" {
                self.statusArray = statusVMArray + self.statusArray!
                // 请求更多
            }else if maxId != "0"{
                self.statusArray =  self.statusArray! + statusVMArray
            }else {
                self.statusArray = statusVMArray
            }
            
            self.cacheImages(self.statusArray, finish: finish)
            
        }
    }
    
    /// 缓存配图
    func cacheImages(_ statusVMs: [StatusViewModel]?, finish: @escaping (_ status: [StatusViewModel]?, _ error: Error?) -> Void)
    {
        // 创建dispatchGroup
        let group = DispatchGroup()
        
        for statusVM in statusVMs!
        {
            guard let pic_urls = statusVM.thumbnail_urls else {
                // 没有配图跳出本次循环
                continue
            }
            for url in pic_urls
            {
                group.enter()
                // 下载图片
                SDWebImageManager.shared().loadImage(with: url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (image, data, error, _, _, _) in
                    MXLog("下载图片")
                    group.leave()
                })
            }
        }
        
        // 当下载完成之后再调用notify方法通知
        group.notify(queue: DispatchQueue.main) {
            finish(statusVMs, nil)
            MXLog("下载完毕")
        }
    }
}
