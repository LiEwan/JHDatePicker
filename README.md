# JHDatePicker
### 根据月份，获取每月1号的起始位置
```
static public func getDateWeekday(date:Date) ->Int{    
     let timeInterval:TimeInterval = date.timeIntervalSince1970
     let days = Int(timeInterval/86400)
     let weekday = ((days+4)%7+7)%7
     return weekday
}
```

### 根据日期，将阳历转换成对应的农历时间
```
static public func solarToLuar(solarDate:Date) ->String{
     let calendar = Calendar.init(identifier: .chinese)
     let formatter = DateFormatter()
     formatter.locale = Locale(identifier:"zh_CN")
     formatter.dateStyle = .medium
     formatter.calendar = calendar
     return formatter.string(from: solarDate)
}
```

