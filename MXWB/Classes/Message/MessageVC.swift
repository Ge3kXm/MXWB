//
//  MessageVC.swift
//  mxwb
//
//  Created by maRk on 17/3/31.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class MessageVC: BaseTableVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !hasLogin {
            visitorView?.setupViews(imageName: "visitordiscover_image_message", title: "发现一些爆炸出轨新闻～")
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }



}
