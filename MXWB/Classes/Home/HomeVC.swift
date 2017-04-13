//
//  ViewController.swift
//  mxwb
//
//  Created by maRk on 17/3/31.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class HomeVC: BaseTableVC
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        let tableView = UITableView(frame : self.view.bounds, style : UITableViewStyle(rawValue: 0)!)
//        tableView.dataSource = self;
//        tableView.delegate = self;
//        self.view.addSubview(tableView)
//        
//        self.view.backgroundColor = UIColor.red
        
    }

}

//extension HomeVC : UITableViewDataSource
//{
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellID = "CellID"
//        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
//        if cell == nil {
//            cell = UITableViewCell(style : UITableViewCellStyle(rawValue: 0)!, reuseIdentifier : cellID)
//        }
//        cell?.backgroundColor = UIColor.orange
//        return cell!
//    }
//}
//
//extension HomeVC : UITableViewDelegate
//{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//    }
//}
