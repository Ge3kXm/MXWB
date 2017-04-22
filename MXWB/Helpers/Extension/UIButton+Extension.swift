//
//  UIButton+Extension.swift
//  mxwb
//
//  Created by maRk on 17/3/31.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

extension UIButton
{
    
    convenience init(imageName: String, backgroundImage: String) {
        self.init()
        
        setImage(UIImage(named: "tabbar_compose_icon_add"), for: UIControlState.normal)
        setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: UIControlState.highlighted)
        
        setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: UIControlState.normal)
        setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: UIControlState.highlighted)
        
        sizeToFit()
    }
    
}
