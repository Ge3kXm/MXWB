//
//  Date+Extension.swift
//  MXWB
//
//  Created by maRk on 2017/4/22.
//  Copyright © 2017年 maRk. All rights reserved.
//

import Foundation

extension Date
{
    /// 根据日期字符串和格式字符串创建日期
    static func creatTime(with timeStr: String, and dateFormatterStr: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatterStr
        // 必须制定local，否则真机中可能会出现未知bug
        formatter.locale = Locale(identifier: "en")
        return formatter.date(from: timeStr)!
    }
    
    /// 格式化输出日期
    func formatterDateDes() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        
        var formatterStr = "HH:mm"
        
        // 获取当前日历
        let calendar = Calendar.current
        
        // 今天
        if calendar.isDateInToday(self) {
            let interval = 50
            
            if interval < 60 {
                return "刚刚"
            }else if interval < 60 * 60
            {
                return "\(interval / 60)分钟前"
            }else if interval < 60 * 60 * 24
            {
                return "\(interval / (60 * 60))小时前"
            }
        // 昨天
        }else if calendar.isDateInYesterday(self) {
            formatterStr = "昨天 " + formatterStr
        // 一天前
        }else {
            // 比较日历中年、月、日的差值
            let comps = calendar.component(Calendar.Component.year, from: self)
            if comps >= 1 {
                // 更早时间
                formatterStr = "yyyy-MM-dd " + formatterStr
            }else {
                // 一年以内
                formatterStr = "MM-dd " + formatterStr
            }
        }
        
        formatter.dateFormat = formatterStr
        return formatter.string(from: self)
    }
    
}
