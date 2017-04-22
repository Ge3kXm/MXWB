//
//  HomeTableViewCell.swift
//  MXWB
//
//  Created by maRk on 2017/4/22.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var verifyIconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var vipIconView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var statusViewMoldel: StatusViewModel? {
        didSet {
            // 头像
            iconImageView.kf.setImage(with: ImageResource(downloadURL: (statusViewMoldel?.icon_URL)!))
            // 认证图标
            verifyIconView.image = statusViewMoldel?.verified_image
            // 昵称
            nameLabel.text = statusViewMoldel?.status.user?.screen_name
            // vip图标
            vipIconView.image = nil
            if let vipIcon = statusViewMoldel?.mbrankImage {
                vipIconView.image = vipIcon
            }
            // 时间
            timeLabel.text = statusViewMoldel?.created_Time
            // 来源
            sourceLabel.text = statusViewMoldel?.source_Text
            // 内容
            contentLabel.text = statusViewMoldel?.status.text
        }
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
}
