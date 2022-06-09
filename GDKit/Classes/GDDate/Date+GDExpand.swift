//
//  Date+GDExpand.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

extension Date {
    
    // 返回聊天室的时间
    public func getShowFormat() -> String {
        
        let requestDate = self
        
        //获取当前时间
        let calendar = Calendar.current
        //判断是否是今天
        if calendar.isDateInToday(requestDate as Date) {
            //获取当前时间和系统时间的差距(单位是秒)
            //强制转换为Int
            let since = Int(Date().timeIntervalSince(requestDate as Date))
            //  是否是刚刚
            if since < 60 {
                return "刚刚"
            }
            //  是否是多少分钟内
            if since < 60 * 60 {
                return "\(since/60)分钟前"
            }
            //  是否是多少小时内
            return "\(since / (60 * 60))小时前"
        }
        
        //判断是否是昨天
        var formatterString = " HH:mm"
        if calendar.isDateInYesterday(requestDate as Date) {
            formatterString = "昨天" + formatterString
        } else {
            //判断是否是一年内
            formatterString = "MM-dd" + formatterString
            //判断是否是更早期
            
            let comps = calendar.dateComponents([Calendar.Component.year], from: requestDate, to: Date())
            
            if let year = comps.year, year >= 1 {
                formatterString = "yyyy-" + formatterString
            }
        }
        
        //按照指定的格式将日期转换为字符串
        //创建formatter
        let formatter = DateFormatter()
        //设置时间格式
        formatter.dateFormat = formatterString
        //设置时间区域
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        
        //格式化
        return formatter.string(from: requestDate as Date)
    }
}
