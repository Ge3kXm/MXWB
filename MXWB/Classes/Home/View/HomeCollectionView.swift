//
//  HomeCollectionView.swift
//  MXWB
//
//  Created by maRk on 2017/5/16.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var colletionLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var clvWidthCon: NSLayoutConstraint!
    @IBOutlet weak var clvHeightCon: NSLayoutConstraint!
    
    var statusViewMoldel: StatusViewModel? {
        didSet {
            reloadData()

            let (itemSize, clvSize) = calculateSize()
            // item不能为zero否则报错
            if itemSize != CGSize.zero
            {
                colletionLayout.itemSize = itemSize
            }
            
            clvHeightCon.constant = clvSize.height;
            clvWidthCon.constant = clvSize.width
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
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
    
    // MARK: - UICollectionViewDataSource
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
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        MXLog(indexPath.item)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: MXWB_NOTIFICATION_COLLECTIONVIEWCELL_SELECTED), object: self, userInfo: ["bmiddle_url": statusViewMoldel!.bmiddle_urls!, "indexPath": indexPath])
    }

}
