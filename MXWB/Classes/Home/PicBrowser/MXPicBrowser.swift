//
//  MXPicBrowser.swift
//  MXWB
//
//  Created by maRk on 2017/5/16.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class MXPicBrowser: UIViewController {
    var urls: [URL]
    var indexPath: IndexPath
    
    lazy var saveButton: UIButton = {
        var saveBtn = UIButton()
        saveBtn.setTitle("保存", for: UIControlState.normal)
        saveBtn.addTarget(self, action: #selector(MXPicBrowser.closeBtnClick), for: UIControlEvents.touchUpInside)
        return saveBtn
    }()
    
    lazy var closeButton: UIButton = {
        var closeBtn = UIButton()
        closeBtn.setTitle("关闭", for: UIControlState.normal)
        closeBtn.addTarget(self, action: #selector(MXPicBrowser.saveBtnClick), for: UIControlEvents.touchUpInside)
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
        return 10
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MXPicBrowserCell", for: indexPath)
        cell.backgroundColor = (indexPath.item % 2 == 1) ? UIColor.red : UIColor.green
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

class MXPicBrowserCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.frame = bounds
//        scrollView.backgroundColor = UIColor.darkGray
    }
    
    lazy var scrollView = UIScrollView()
    lazy var imageView = UIImageView()
}

