//
//  GDDateHelper.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

class GDDateHelper {

    static let shared = GDDateHelper()
    
    private let dateFormatter: DateFormatter
    
    private init() {
        
        dateFormatter = DateFormatter()
    }
    
    /// 时间转字符串
    ///
    /// - Parameters:
    ///   - date: 时间
    ///   - dateFormat: 时间格式
    /// - Returns: 字符串
    func dateConvertString(date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {

        dateFormatter.dateFormat = dateFormat
        let sourceTimeZone = NSTimeZone.system
        dateFormatter.timeZone = sourceTimeZone
        let dateForString = dateFormatter.string(from: date)
        return dateForString
    }
    
    /// 时间转本地时间
    ///
    /// - Parameter date: 时间
    /// - Returns: 本地时间
    func dateLocal(date: Date) -> Date {
        
        let zone = NSTimeZone.system as NSTimeZone
        let interval: Int = zone.secondsFromGMT(for: date)
        let localeDate = date.addingTimeInterval(TimeInterval(interval))
        return localeDate
    }
    
    /// 字符串转时间
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - dateFormat: 时间格式
    /// - Returns: 时间
    func stringConvertDate(string: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: string)
        return date ?? Date()
    }
    
    /// 时间戳转换成 时、分、秒
    ///
    /// - Parameter timeNum: 时间戳
    /// - Returns: 时分秒数组返回
    class func calculationTime(timeNum:Int) -> Array<Any> {
        
        var hourTemp = 0
        var minuteTemp = 0
        var secondeTemp = 0
        
        hourTemp = timeNum/(60*60) > 0 ? timeNum/(60*60) : 0
        minuteTemp = (timeNum-hourTemp*60*60)/60 > 0 ? (timeNum-hourTemp*60*60)/60 : 0
        secondeTemp = (timeNum-hourTemp*60*60-minuteTemp*60) > 0 ? (timeNum-hourTemp*60*60-minuteTemp*60) : 0
        
        let dateArray = [hourTemp,minuteTemp,secondeTemp]
        
        return dateArray
    }
    
    //MARK:- 时间戳转成字符串
    func timeIntervalChangeToTimeStr(timeInterval:TimeInterval, dateFormat:String?) -> String {
        let date:NSDate = NSDate.init(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date as Date)
    }
    //MARK:- 字符串转时间戳
    func timeStrChangeTotimeInterval(timeStr: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> TimeInterval {
        let format = DateFormatter.init()
        format.dateFormat = dateFormat
        let date = format.date(from: timeStr)
        return date?.timeIntervalSince1970 ?? 0
    }
    
    func isExpired(time: String) -> Bool {
        let date = self.stringConvertDate(string: time, dateFormat: "yyyy-MM-dd")
        let now:Date = Date.init()
        if date.compare(now) == ComparisonResult.orderedAscending {
            return false
        } else if date.compare(now) == ComparisonResult.orderedDescending {
            return true
        } else if date.compare(now) == ComparisonResult.orderedSame {
            
        }
        return false
    }
    //MARK:- 第二天
    func getNextDateStr() -> String {
        let now = Date.init()
        let time:TimeInterval = now.timeIntervalSince1970 + 24*60*60
        let nextDate = GDDateHelper.shared.timeIntervalChangeToTimeStr(timeInterval: time, dateFormat: "yyyy-MM-dd")
        return nextDate
    }
    //MARK:- 今天
    func getTodayDateStr() -> String {
        let now = Date.init()
        let time:TimeInterval = now.timeIntervalSince1970
        let todayDate = GDDateHelper.shared.timeIntervalChangeToTimeStr(timeInterval: time, dateFormat: "yyyy-MM-dd")
        return todayDate
    }
    //MARK:- 第二天
    func getNextDate() -> Date {
        let now = Date.init()
        let time:TimeInterval = now.timeIntervalSince1970 + 1*24*60*60
        let date = Date.init(timeIntervalSince1970: time)
        return date
    }
    //MARK:- 今天
    func getTodayDate() -> Date {
        let now = Date.init()
        let time:TimeInterval = now.timeIntervalSince1970
        let date = Date.init(timeIntervalSince1970: time)
        return date
    }
    //本月开始日期
    func startOfCurrentMonth() -> Date {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]), from: date)
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
     
    //本月结束日期
    func endOfCurrentMonth(returnEndTime:Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
         
        let endOfMonth =  calendar.date(byAdding: components, to: startOfCurrentMonth())!
        return endOfMonth
    }
    
    /// 获取上几个月的时间
    func getLastMonth(num : Int, dateFormat:String) -> String {
        let curDate = dateLocal(date: Date()) 
        let formater = DateFormatter()
        formater.dateFormat = dateFormat
        
        let calendar = Calendar(identifier: .gregorian)
        var lastMonthComps = DateComponents()
        // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
        lastMonthComps.month = -num
        let newDate = calendar.date(byAdding: lastMonthComps, to: curDate)
        let dateStr = formater.string(from: newDate!)
        
        return dateStr
    }
}
