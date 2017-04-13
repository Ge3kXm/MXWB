//
//  TitleButton.swift
//  MXWB
//
//  Created by maRk on 2017/4/13.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        setImage(UIImage.init(named: "navigationbar_arrow_down"), for: UIControlState.normal)
        setImage(UIImage.init(named: "navigationbar_arrow_up"), for: UIControlState.selected)
        
        setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        sizeToFit()
    }
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle((title ?? "") + "", for: UIControlState.normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0;
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)!;
    }
}
