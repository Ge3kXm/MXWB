//
//  HomeCollectionViewCell.swift
//  MXWB
//
//  Created by maRk on 2017/4/25.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var url: URL? {
        didSet {
            imageView.sd_setImage(with: url)
        }
    }

}
