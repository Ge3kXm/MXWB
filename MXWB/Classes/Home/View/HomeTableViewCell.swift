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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var colletionLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var clvWidthCon: NSLayoutConstraint!
    @IBOutlet weak var clvHeightCon: NSLayoutConstraint!
    
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

            let (itemSize, clvSize) = calculateSize()
            // item不能为zero否则报错
            if itemSize != CGSize.zero
            {
                colletionLayout.itemSize = itemSize
            }
            
            clvHeightCon.constant = clvSize.height;
            clvWidthCon.constant = clvSize.width
            
            // 更新collectionView
            collectionView.reloadData()
        }
    }
    
    // MARK: - PrivateFunc
    /// 计算item Size和collectionView Size
    private func calculateSize() -> (CGSize, CGSize)
    {
        let count = statusViewMoldel?.thumbnail_urls?.count ?? 0
        
        // 没有配图
        if count == 0 {
            return (CGSize.zero, CGSize.zero)
        }
    
        // 有一张配图时按照图片的大小来设置cell的大小
        if count == 1 {
            // 从缓存中取出图片，且一定有图
            let image = SDWebImageManager.shared().imageCache!.imageFromCache(forKey: statusViewMoldel!.thumbnail_urls!.first!.absoluteString)!
            return (image.size, image.size)
        }
        
        let imageWidth: CGFloat = 90
        let imageHeight: CGFloat = 90
        let imageMargin: CGFloat = 10
        
        // 四张配图或以上时固定大小
        if count == 4
        {
            let col = 2
            let row = col
            let width = imageWidth * CGFloat(col) + CGFloat(col - 1) * imageMargin
            let height = imageHeight * CGFloat(row) + CGFloat(row - 1) * imageMargin
            return (CGSize(width: imageWidth, height: imageHeight), CGSize(width: width, height: height))
        }
        
        // 其他张配图
        let col = 3
        let row = (count - 1) / 3 + 1
        let width = imageWidth * CGFloat(col) + CGFloat(col - 1) * imageMargin
        let height = imageHeight * CGFloat(row) + CGFloat(row - 1) * imageMargin
        
        return (CGSize(width: imageWidth, height: imageHeight), CGSize(width: width, height: height))
    }
    
    /// 计算Cell的高度
    func calculateCellHeight(statusVM: StatusViewModel) -> CGFloat
    {
        self.statusViewMoldel = statusVM
        
        self.layoutIfNeeded()
        
        let cellHeight = collectionView.frame.maxY
        
        MXLog(bottomView.frame)
        MXLog(cellHeight)
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

extension HomeTableViewCell: UICollectionViewDataSource
{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.statusViewMoldel?.thumbnail_urls?.count ?? 0
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeColletionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.url = self.statusViewMoldel?.thumbnail_urls?[indexPath.row];
        return cell
    }
}

