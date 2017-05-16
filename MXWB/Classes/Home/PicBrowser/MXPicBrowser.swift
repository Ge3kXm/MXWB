//
//  MXPicBrowser.swift
//  MXWB
//
//  Created by maRk on 2017/5/16.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit
import SDWebImage

class MXPicBrowser: UIViewController {
    var urls: [URL]
    var indexPath: IndexPath
    
    lazy var saveButton: UIButton = {
        var saveBtn = UIButton()
        saveBtn.setTitle("保存", for: UIControlState.normal)
        saveBtn.addTarget(self, action: #selector(MXPicBrowser.saveBtnClick), for: UIControlEvents.touchUpInside)
        return saveBtn
    }()
    
    lazy var closeButton: UIButton = {
        var closeBtn = UIButton()
        closeBtn.setTitle("关闭", for: UIControlState.normal)
        closeBtn.addTarget(self, action: #selector(MXPicBrowser.closeBtnClick), for: UIControlEvents.touchUpInside)
        return closeBtn
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: MXPicBrowserLayout())
        collectionView.register(MXPicBrowserCell.self, forCellWithReuseIdentifier: "MXPicBrowserCell")
        collectionView.dataSource = self
        return collectionView
    }()
    
    @objc func closeBtnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveBtnClick() {
        
    }
    
    init(urls: [URL], indexPath: IndexPath) {
        self.urls = urls
        self.indexPath = indexPath
        // 自定义构造方法时不一定调用init()，也可能为设计构造方法
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(saveButton)
        view.addSubview(closeButton)
        
        initConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: false)
    }
    
    func initConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["collectionView": collectionView])
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["collectionView": collectionView])
        view.addConstraints(cons)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        let dict = ["closeButton": closeButton, "saveButton": saveButton]
        let closeHCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[closeButton(100)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        let closeVCons = NSLayoutConstraint.constraints(withVisualFormat: "V:[closeButton(50)]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        view.addConstraints(closeHCons)
        view.addConstraints(closeVCons)
        
        let saveHCons = NSLayoutConstraint.constraints(withVisualFormat: "H:[saveButton(100)]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        let saveVCons = NSLayoutConstraint.constraints(withVisualFormat: "V:[saveButton(50)]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        view.addConstraints(saveHCons)
        view.addConstraints(saveVCons)
    }
}

extension MXPicBrowser: UICollectionViewDataSource
{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MXPicBrowserCell", for: indexPath) as! MXPicBrowserCell
        cell.backgroundColor = (indexPath.item % 2 == 1) ? UIColor.red : UIColor.green
        cell.url = urls[indexPath.item]
        return cell
    }
}


class MXPicBrowserLayout: UICollectionViewFlowLayout {
    override func prepare() {
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.horizontal
        
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}

class MXPicBrowserCell: UICollectionViewCell, UIScrollViewDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    var url: URL? {
        didSet {
            // 重置view，防止图片缩放带来的复用显示问题
            resetView()
            
            imageView.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed) { (image, error, _, _) in
                
                let height = UIScreen.main.bounds.height
                let width = UIScreen.main.bounds.width

                let scale = (image?.size.height)! / (image?.size.width)!
                
                let imageHeight = width * scale
                
                self.imageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: imageHeight))
                
                // 图片高大于屏幕高
                if imageHeight > height {
                    self.scrollView.contentSize = CGSize(width: width, height: imageHeight)
                }else {
                    let offsetY = (height - imageHeight) * 0.5
                    self.scrollView.contentInset = UIEdgeInsetsMake(offsetY, 0, offsetY, 0)
                }
            }

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.frame = bounds
        scrollView.backgroundColor = UIColor.darkGray
    }
    
    func resetView() {
        // 重置set和缩放
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.contentOffset = CGPoint.zero
        scrollView.contentSize = CGSize.zero
        
        imageView.transform = CGAffineTransform.identity
    }
    
    // 哪个控件需要缩放
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        
        var offsetX = (imageView.frame.size.width - width) * 0.5
        var offsetY = (imageView.frame.size.height - height) * 0.5
        
        offsetX = offsetX < 0 ? 0 : offsetX
        offsetY = offsetY < 0 ? 0 : offsetY
        
        scrollView.contentInset = UIEdgeInsetsMake(offsetX, offsetY, offsetX, offsetY)
    }
    
    lazy var scrollView: UIScrollView = {
        let sc = UIScrollView()
        sc.maximumZoomScale = 2.0
        sc.minimumZoomScale = 0.5
        sc.delegate = self
        return sc
    }()
    lazy var imageView = UIImageView()
}

