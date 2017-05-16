//
//  StatusViewModel.swift
//  MXWB
//
//  Created by maRk on 2017/4/22.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {
    var status: StatusModel
    
    /// 用户认证图片
    var verified_image: UIImage?
    /// 会员图片
    var mbrankImage: UIImage?
    /// 用户头像URL地址
    var icon_URL: URL?
    /// 微博格式化之后的创建时间
    var created_Time: String = ""
    /// 微博格式化之后的来源
    var source_Text: String = ""
    /// 配图Url
    var thumbnail_urls: [URL]?
    /// 缓存转发文字
    var forward_Text: String?
    /// 点击后的大图
    var bmiddle_urls: [URL]?
    
    init(status: StatusModel)
    {
        self.status = status
        // 会员图标处理
        if (status.user?.mbrank)! >= 1 && (status.user?.mbrank)! <= 6  {
            mbrankImage = UIImage(named: "common_icon_membership_level\(status.user!.mbrank)")
        }
        
        // 认证图标处理
        switch status.user?.verified_type ?? -1 {
        case 0:
            verified_image = UIImage(named: "avatar_vip")
            break
        case 2, 3, 5:
            verified_image = UIImage(named: "avatar_enterprise_vip")
            break
        case 220:
            verified_image = UIImage(named: "avatar_grassroot")
            break
        default:
            verified_image = nil
            break
        }
        
        // 来源处理
        if let sourceStr = status.source, sourceStr != ""{
//            let startIndex = (sourceStr.range(of: "<") as! NSRange).location
//            let length = sourceStr.rang
//            let length = sourceStr.rangeOfString("<", options: NSStringCompareOptions.BackwardsSearch).location - startIndex
//            let rest = sourceStr.substringWithRange(NSMakeRange(startIndex, length))
            source_Text = "习近平的iphone"
        }
        
        // 处理时间
        if let timeStr = status.created_at, timeStr != "" {
            let date = Date.creatTime(with: timeStr, and: "EE MM dd HH:mm:ss Z yyyy")
            created_Time = date.formatterDateDes()
        }
        
        // 处理头像
        icon_URL = URL(string: status.user?.profile_image_url ?? "")
        
        // 缓存图片url地址
        if let urls = status.retweeted_status?.pic_urls?.count != 0 ? status.retweeted_status?.pic_urls : status.pic_urls {
            thumbnail_urls = [URL]()
            bmiddle_urls = [URL]()
            for dic in urls {
                guard let thumbnail_pic = dic["thumbnail_pic"] as? String else {
                    // 为空跳出本场for循环
                    continue
                }
                // 缩略图
                let thumbnail_url = URL(string: thumbnail_pic)!
                thumbnail_urls?.append(thumbnail_url)
                
                // 大图
                let bmiddle = thumbnail_pic.replacingOccurrences(of: "thumbnail", with: "bmiddle")
                bmiddle_urls?.append(URL(string: bmiddle)!)
            }
        }
        
        // 处理转发文字
        if let text = status.retweeted_status?.text
        {
            let name = status.user?.screen_name ?? ""
            forward_Text = "@" + name + ":" + text
        }

    }
    

}
