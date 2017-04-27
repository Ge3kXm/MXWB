//
//  MXLog.swift
//  mxwb
//
//  Created by maRk on 2017/4/12.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

func MXLog<T> (_ message: T, fileName: String = #file, funcName: String = #function, lineNumber: Int = #line){
    #if DEBUG
        print("\(funcName)" + "lineNumber:" + "\(lineNumber)" + "message" + "\(message)")
    #else
    
    #endif
}
