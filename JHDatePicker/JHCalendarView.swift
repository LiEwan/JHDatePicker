//
//  JHCalendarView.swift
//  JHDatePicker
//
//  Created by Ewan Li on 2019/10/27.
//  Copyright © 2019 Ewan Li. All rights reserved.
//

import UIKit
let btnW = (KScreenW - 30) / 7.0
let btnH = 50.0
class JHCalendarView: JHBaseCalendarView {

   var currentYear:Int?
    var currentMonth:Int?
    var currentDay:Int?
    
    var mutltiSelect:Bool? // 多选还是单选
    typealias selectDateBlock = (_ selecDate:NSMutableArray) -> ()
    typealias cancelDateBlock = () -> ()
    
    var dateBlock:selectDateBlock!
    var cancelBlock:cancelDateBlock!
    class func showCalendarView(mutlipleSelect:Bool,resultBlock:@escaping selectDateBlock,cancelBlock:@escaping cancelDateBlock){
        let calendarView = JHCalendarView.init(mutlipleSelect:mutlipleSelect,selectColor: UIColor.white, resultBlock: resultBlock, cancelBlock: cancelBlock)
        calendarView.showAnimation(animation: true)
    }
    init(mutlipleSelect:Bool,selectColor:UIColor?,resultBlock:@escaping selectDateBlock,cancelBlock:@escaping cancelDateBlock) {
        self.init()
        self.dateBlock = resultBlock
        self.cancelBlock = cancelBlock
        let date = Date()
        currentYear = date.jh_year()
        currentMonth = date.jh_month()
        initUI()
        self.mutltiSelect = mutlipleSelect
        self.getCurrentMonth(year: currentYear!, month: currentMonth!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func initUI() {
        super.initUI()
        self.alertView.addSubview(self.weekendView)
        self.alertView.addSubview(self.calendarView)
        
        let weekdaysTitleArr = ["周日","周一","周二","周三","周四","周五","周六"]
        
        for i in 0 ... 6{
            let lbl = UILabel.createLabel(weekdaysTitleArr[i], HexRGBAlpha(0x252525,1.0), 14, .center)
            lbl.frame = CGRect(x: 15 + CGFloat(i) * btnW, y: 0, width: btnW, height: CGFloat(btnH))
            self.weekendView.addSubview(lbl)
        }
    }
    override func clickLeftBtn() {
        currentMonth! -= 1
        if currentMonth! < 1{
            currentMonth = 12
            currentYear! -= 1
        }
        self.getCurrentMonth(year: currentYear!, month: currentMonth!)
        
    }
    override func clickRightBtn() {
        currentMonth! += 1
        if currentMonth! > 12 {
            currentMonth = 1
            currentYear! += 1
        }
        self.getCurrentMonth(year: currentYear!, month: currentMonth!)
    }
    private func getCurrentMonth(year:Int,month:Int){
        let dateStr = String(format: "%d-%02d", year,month)
        let currentDate = Date.jh_getDate(dateString: dateStr, format: "yyyy-MM")
        self.titleLbl.text = Date.jh_getDateString(date: currentDate!, format: "yyyy-MM")
        for view in self.calendarView.subviews {
            view.removeFromSuperview()
        }
        self.getTotalDay()
    }
    private func getTotalDay(){
        let days = Date.jh_getDaysInYear(year: currentYear!, month: currentMonth!)
        
        self.initDateBtn(days)
    }

    private func initDateBtn(_ day:Int){
        let startIndex = self.getStartIndex()
        self.setNeedsUpdateConstraints()
        for i in 0 ..< day {
            let row = (i + startIndex + 1) > 7 ? ((i + startIndex) / 7) : 0 // 当前行
            let column = (i + startIndex + 1) > 7 ? ((i + startIndex) - row * 7) : i // 当前所在的列
            let frame = CGRect(x:15 + CGFloat(column) * btnW + (row > 0 ? 0 : CGFloat(startIndex) * btnW), y: CGFloat(row) * CGFloat(btnH), width: btnW, height: CGFloat(btnH))
            let dateStr = String(format: "%d-%02d-%02d", currentYear!,currentMonth!,i + 1)
            let date = Date.jh_getDate(dateString: dateStr, format: "yyyy-MM-dd")
            let solarStr = Date.solarToLuar(solarDate: date!)
            var dayStr = NSString(format: "%@", solarStr).substring(with: NSMakeRange(7, 2))
            if dayStr == "初一"{
                dayStr = NSString(format: "%@", solarStr).substring(with: NSMakeRange(5, 2))
            }
            let button = JHLblTitleButton.jhLblTitleButtonWithTitle(title: String(format: "%d", i + 1), msg: dayStr)
            button.frame = frame
            button.tag = i + 1
            if dateStr == Date.jh_getDateString(date: Date(), format: "yyyy-MM-dd"){
                button.backgroundColor = HexRGBAlpha(0x00bccc,1.0)
            }
            self.getSelectDate(dateStr, button)
            button.addTarget(self, action: #selector(selectDate(_:)), for: .touchUpInside)
            button.layer.cornerRadius = 25
            self.calendarView.addSubview(button)
        }
    }
    private func getSelectDate(_ dateStr:String,_ button:UIButton){
        for i in self.selectArray {
            if i as! String == dateStr {
                button.backgroundColor = HexRGBAlpha(0x21aceb,1.0)
                button.isSelected = true
            }
        }
    }
    @objc func selectDate(_ sender:Any){
        let btn = sender as! UIButton
        if self.mutltiSelect == false{
            self.selectArray.removeAllObjects()
        }
        btn.isSelected = !btn.isSelected
        let dateStr = String(format: "%d-%02d-%02d", currentYear!,currentMonth!,btn.tag)
        if btn.isSelected == true{
            if self.selectArray.contains(dateStr) == false{
                self.selectArray.add(dateStr)
            }
            btn.backgroundColor = HexRGBAlpha(0x21aceb,1.0)
        }else if btn.isSelected == false{
            btn.backgroundColor = UIColor.clear
            if self.selectArray.contains(dateStr) {
                self.selectArray.remove(dateStr)
            }
        }
        self.dateBlock(self.selectArray)
    }
    override func updateConstraints() {
        super.updateConstraints()
        let day = Date.jh_getDaysInYear(year: currentYear!, month: currentMonth!)
        let startIndex = self.getStartIndex()
        var frame = self.calendarView.frame
        let totalRow = (day - (7 - startIndex)) % 7 == 0 ? (day - (7 - startIndex)) / 7 : (day - (7 - startIndex)) / 7 + 1
        frame.size.height = CGFloat((totalRow + 1)) * CGFloat(btnH)
        self.calendarView.frame = frame
        var rect = self.alertView.frame
        rect.size.height = 45 + CGFloat((totalRow + 2)) * CGFloat(btnH)
        rect.origin.y = KScreenH - (45 + CGFloat((totalRow + 2)) * CGFloat(btnH)) - bottomHeight
        self.alertView.frame = rect
    }
    private func showAnimation(animation:Bool){
        UIApplication.shared.keyWindow?.addSubview(self)
        if animation == true {
            var rect = self.alertView.frame
            rect.origin.y = KScreenH
            self.alertView.frame = rect
            UIView.animate(withDuration: 0.2, animations: {
                var rect = self.alertView.frame
                rect.origin.y -= CGFloat(btnH * 6) + 45 + bottomHeight
                self.alertView.frame = rect
            })
        }
    }
    private func getStartIndex() -> Int{
        let dateStr = String(format: "%d-%02d-01", currentYear!,currentMonth!)
        let date = Date.jh_getDate(dateString: dateStr, format: "yyyy-MM-dd")
        return Date.getDateWeekday(date: date!)
    }
    lazy var calendarView:UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 45 + CGFloat(btnH), width: KScreenW, height: CGFloat(btnH * 5)))
        view.backgroundColor = UIColor.white
        return view
    }()
    lazy var weekendView:UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 45, width: KScreenW, height: CGFloat(btnH)))
        view.backgroundColor = UIColor.white
        return view
    }()
    lazy var selectArray:NSMutableArray = {
        let array = NSMutableArray()
        return array
    }()

}
