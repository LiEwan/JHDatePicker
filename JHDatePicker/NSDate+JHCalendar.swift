//
//  NSDate+JHCalendar.swift
//  JHDatePicker
//
//  Created by Ewan Li on 2019/10/27.
//  Copyright © 2019 Ewan Li. All rights reserved.
//

import Foundation

let unitFlags = Set<Calendar.Component>([.year,.month,.day,.hour,.minute,.second,.weekdayOrdinal])

extension Date{
    static public func currentCalendar() -> Calendar{
        let calendar = Calendar.autoupdatingCurrent
        return calendar
    }
    public func jh_year() -> NSInteger{
        let components = Date.currentCalendar().dateComponents(unitFlags, from: self)
        return components.year ?? 2000
    }
    public func jh_month() -> NSInteger{
     let components = Date.currentCalendar().dateComponents(unitFlags, from: self)
        return components.month ?? 1
    }
    public func jh_day() -> NSInteger{
        let components = Date.currentCalendar().dateComponents(unitFlags, from: self)
        return components.day ?? 1
    }
    public func jh_hour() ->NSInteger{
        let components = Date.currentCalendar().dateComponents(unitFlags, from: self)
        return components.hour ?? 0
    }
    public func jh_minter() -> NSInteger{
        let components = Date.currentCalendar().dateComponents(unitFlags, from: self)
        return components.minute ?? 0
    }
    public func jh_second() ->NSInteger{
        let components = Date.currentCalendar().dateComponents(unitFlags, from: self)
        return components.second ?? 0
    }
    public func jh_weekend() ->NSInteger{
        let components = Date.currentCalendar().dateComponents(unitFlags, from: self)
        return components.weekday ?? 0
    }
    
    /// 日期转换成星期几
    ///
    /// - Parameter date: 日期
    /// - Returns: 星期几
    static public func getDateWeekday(date:Date) ->Int{
//        let weekdaysTitleArr = ["周日","周一","周二","周三","周四","周五","周六"]
        let timeInterval:TimeInterval = date.timeIntervalSince1970
        let days = Int(timeInterval/86400)
        let weekday = ((days + 4)%7+7)%7
//        return weekdaysTitleArr[weekday]
        return weekday
    }
    static public func jh_setYear(year:NSInteger,month:NSInteger,day:NSInteger,hour:NSInteger,minute:NSInteger,second:NSInteger) -> Date{
        let calendar = Date.currentCalendar()
        var components = calendar.dateComponents(unitFlags, from: Date())
        if year >= 0 {
            components.year = year
        }
        if month >= 0 {
            components.month = month
        }
        if day >= 0{
            components.day = day
        }
        if hour >= 0 {
            components.hour = hour
        }
        if minute >= 0 {
            components.minute = minute
        }
        if second >= 0 {
            components.second = second
        }
        return calendar.date(from: components)!
    }
    public static func jh_setYear(year:NSInteger,month:NSInteger,day:NSInteger,hour:NSInteger,minute:NSInteger) -> Date{
        return self.jh_setYear(year: year, month: month, day: day, hour: hour, minute: minute, second: -1)
    }
    static public func jh_setYear(year:NSInteger,month:NSInteger,day:NSInteger) -> Date{
        return self.jh_setYear(year: year, month: month, day: day, hour: -1, minute: -1, second: -1)
    }
    static public func jh_setYear(year:NSInteger,month:NSInteger) -> Date{
        return self.jh_setYear(year: year, month: month, day: -1, hour: -1, minute: -1, second: -1)
    }
    static public func jh_setYear(year:NSInteger) -> Date{
        return self.jh_setYear(year: year, month: -1, day: -1, hour: -1, minute: -1, second: -1)
    }
    static public func jh_setMonth(month:NSInteger,day:NSInteger,hour:NSInteger,minute:NSInteger) -> Date{
        return self.jh_setYear(year: -1, month: month, day: day, hour: hour, minute: minute, second: -1)
    }
    static public func jh_setMonth(month:NSInteger,day:NSInteger) -> Date{
        return self.jh_setYear(year: -1, month: month, day: day, hour: -1, minute: -1, second: -1)
    }
    static public func jh_setHour(hour:NSInteger,minute:NSInteger) -> Date{
        return self.jh_setYear(year: -1, month: -1, day: -1, hour: hour, minute: minute, second: -1)
    }
    static public func setYear(year:NSInteger) -> Date{
        return self.jh_setYear(year: year)
    }
    static public func setYear(year:NSInteger,month:NSInteger) -> Date{
        return self.jh_setYear(year: year, month: month)
    }
    static public func setYear(year:NSInteger,month:NSInteger,day:NSInteger) -> Date{
        return self.jh_setYear(year: year, month: month, day: day)
    }
    static public func setYear(year:NSInteger,month:NSInteger,day:NSInteger,hour:NSInteger,minute:NSInteger) -> Date{
        return self.jh_setYear(year: year, month: month, day: day, hour: hour, minute: minute)
    }
    static public func setMonth(month:NSInteger,day:NSInteger,hour:NSInteger,minute:NSInteger) -> Date{
        return self.jh_setMonth(month: month, day: day, hour: hour, minute: minute)
    }
    static public func setMonth(month:NSInteger,day:NSInteger) -> Date{
        return self.jh_setMonth(month: month, day: day)
    }
    static public func setHour(hour:NSInteger,minute:NSInteger) -> Date{
        return self.jh_setHour(hour: hour, minute: minute)
    }
    static func jh_getDateString(date:Date,format:String) -> String{
        let components = DateFormatter()
        components.dateFormat = format
        return components.string(from: date as Date)
    }
    static func jh_getDate(dateString:String,format:String) -> Date? {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale.current
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: dateString)
        let zone = NSTimeZone.system
        return date?.addingTimeInterval(TimeInterval(zone.secondsFromGMT(for: date!)))
    }
    static public func jh_getDaysInYear(year:NSInteger,month:NSInteger) -> Int{
        let date = Date.jh_getDate(dateString: "\(year)-\(month)", format: "yyyy-MM")
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let range = calendar.range(of: Calendar.Component.day, in: Calendar.Component.month, for: date!)
        return range?.count ?? 0
    }
    static public func jh_getNewDate(date:Date,addDays:TimeInterval) -> Date{
        return date.addingTimeInterval(3600 * 24 * addDays) as Date
    }
    dynamic public func jh_compare(targetDate:Date,format:String) -> Bool{
        let dateStr1 = Date.jh_getDateString(date: self, format: format)
        let dateStr2 = Date.jh_getDateString(date: targetDate, format: format)
        let date1 = Date.jh_getDate(dateString: dateStr1, format: format)
        let date2 = Date.jh_getDate(dateString: dateStr2, format: format)
        if date1!.compare(date2!) == ComparisonResult.orderedDescending{
            return false
        }else if date1!.compare(date2!) == ComparisonResult.orderedAscending{
            return true
        }else{
            return true
        }
    }
    
    /// 阳历转换成g农历
    ///
    /// - Parameter solarDate: 日期
    /// - Returns: 对应的农历
    static public func solarToLuar(solarDate:Date) -> String{
        let calendar = Calendar.init(identifier: .chinese)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .medium
        formatter.calendar = calendar
        return formatter.string(from: solarDate)
        
    }
}
