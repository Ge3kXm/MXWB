//
//  HomeTableViewCell.swift
//  MXWB
//
//  Created by maRk on 2017/4/22.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var verifyIconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var vipIconView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var collectionView: HomeCollectionView!

    
    var statusViewMoldel: StatusViewModel? {
        didSet {
            // 头像
            iconImageView.sd_setImage(with: statusViewMoldel?.icon_URL)
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
            
            // 设置配图
            collectionView.statusViewMoldel = statusViewMoldel
        }
    }

    /// 计算Cell的高度
    func calculateCellHeight(statusVM: StatusViewModel) -> CGFloat 
    {
        self.statusViewMoldel = statusVM
        
        self.layoutIfNeeded()
        
        let cellHeight = bottomView.frame.maxY
        
        return cellHeight
    }
    
    // MARK: - InitFunc
    override func awakeFromNib()
    {
        super.awakeFromNib()
        initUI()
        registerCell()
    }
    
    /// 初始化属性
    func initUI()
    {
        nameLabel.sizeToFit()
        timeLabel.sizeToFit()
    }
    
    /// 注册Cell
    private func registerCell()
    {
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeColletionViewCell")
    }
}



