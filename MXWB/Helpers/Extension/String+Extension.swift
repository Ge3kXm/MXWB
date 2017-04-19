//
//  String+Extension.swift
//  MXWB
//
//  Created by maRk'sTheme on 2017/4/18.
//  Copyright © 2017年 maRk. All rights reserved.
//

import Foundation

extension String
{
    /// 获取cache路径
    func cacheDir() -> String {
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let name = (self as NSString).lastPathComponent
        let fullPath = (filePath as NSString).appendingPathComponent(name)
        MXLog(fullPath)
        return fullPath
    }
    
    /// 获取temp路径
    func tempDir() -> String {
        let filePath = NSTemporaryDirectory()
        let name = (self as NSString).lastPathComponent
        let fullPath = (filePath as NSString).appendingPathComponent(name)
        
        return fullPath
    }
    
    /// 获取doc路径
    func docDir() -> String {
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let name = (self as NSString).lastPathComponent
        let fullPath = (filePath as NSString).appendingPathComponent(name)
        
        return fullPath
    }
    
}
