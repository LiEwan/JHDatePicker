//
//  JHBaseCalendarView.swift
//  JHDatePicker
//
//  Created by Ewan Li on 2019/10/27.
//  Copyright © 2019 Ewan Li. All rights reserved.
//

import UIKit

class JHBaseCalendarView: UIView {

   func initUI(){
        self.frame = UIScreen.main.bounds
        self.autoresizingMask = [.flexibleBottomMargin,.flexibleRightMargin,.flexibleWidth,.flexibleHeight]
        self.addSubview(self.backgroundView)
        self.addSubview(self.alertView)
        self.alertView.addSubview(self.headView)
        self.headView.addSubview(self.leftBtn)
        self.headView.addSubview(self.rightBtn)
        self.headView.addSubview(self.titleLbl)
        self.headView.addSubview(self.lineLbl)
    }
    func setupThemeColor(themeColor:UIColor){
        self.leftBtn.layer.cornerRadius = 6.0
        self.leftBtn.layer.borderColor = themeColor.cgColor
        self.leftBtn.layer.borderWidth = 1.0
        self.leftBtn.layer.masksToBounds = true
        self.leftBtn.setTitleColor(themeColor, for: .normal)
        
        self.rightBtn.backgroundColor = themeColor
        self.rightBtn.layer.cornerRadius = 6.0
        self.rightBtn.layer.masksToBounds = true
        self.rightBtn.setTitleColor(UIColor.white, for: .normal)
        self.titleLbl.textColor = themeColor.withAlphaComponent(0.8)
    }
    lazy var backgroundView:UIView = {
        let backgroundView = UIView.init(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        backgroundView.autoresizingMask = [.flexibleBottomMargin,.flexibleWidth,.flexibleRightMargin,.flexibleHeight]
        backgroundView.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(didTapBackgroundView))
        backgroundView.addGestureRecognizer(tapGes)
        return backgroundView
    }()
    lazy var alertView:UIView = {
        let alertView = UIView.init(frame: CGRect(x: 0, y: KScreenH - (45 + CGFloat(btnH * 6)) - bottomHeight, width: KScreenW, height: 45 + CGFloat(btnH * 6) + bottomHeight))
        alertView.backgroundColor = UIColor.white
        alertView.autoresizingMask = [.flexibleTopMargin,.flexibleRightMargin,.flexibleWidth]
        return alertView
    }()
    
    lazy var headView:UIView = {
        let headView = UIView.init(frame: CGRect(x: 0, y: 0, width: KScreenW, height: 44 + 0.5))
        headView.backgroundColor = HexRGBAlpha(0xfdfdfd,1.0)
        headView.autoresizingMask = [.flexibleBottomMargin,.flexibleRightMargin,.flexibleWidth]
        return headView
    }()
    
    lazy var leftBtn:UIButton = {
        let cancelBtn = UIButton.createButton("上一月", HexRGBAlpha(0x969696,1.0), 15, "")
        cancelBtn.backgroundColor = HexRGBAlpha(0xfdfdfd,1.0)
        cancelBtn.autoresizingMask = [.flexibleBottomMargin,.flexibleRightMargin]
        cancelBtn.frame = CGRect(x: 5, y: 7, width: 80, height: 30)
        cancelBtn.addTarget(self, action: #selector(clickLeftBtn), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var rightBtn:UIButton = {
        let rightBtn = UIButton.createButton("下一月", HexRGBAlpha(0x00bccc,1.0), 15, "")
        rightBtn.backgroundColor = HexRGBAlpha(0xfdfdfd,1.0)
        rightBtn.autoresizingMask = [.flexibleBottomMargin,.flexibleLeftMargin]
        rightBtn.addTarget(self, action: #selector(clickRightBtn), for: .touchUpInside)
        rightBtn.frame = CGRect(x: self.alertView.frame.size.width - 85, y: 7, width: 80, height: 30)
        return rightBtn
    }()
    lazy var titleLbl:UILabel = {
        let titleLbl = UILabel.init(frame: CGRect(x: 90, y: 0, width: KScreenW - 180 , height: 44))
        titleLbl.autoresizingMask = [.flexibleBottomMargin,.flexibleRightMargin,.flexibleWidth]
        titleLbl.textColor = HexRGBAlpha(0x969696,1.0)
        titleLbl.textAlignment = NSTextAlignment.center
        return titleLbl
    }()
    
    lazy var lineLbl:UILabel = {
        let lineLbl = UILabel.init(frame: CGRect(x: 0, y: 44, width: KScreenW, height: 0.5))
        lineLbl.backgroundColor = HexRGBAlpha(0xf1f1f1,1.0)
        lineLbl.autoresizingMask = [.flexibleBottomMargin,.flexibleRightMargin,.flexibleWidth]
        self.alertView.addSubview(lineLbl)
        return lineLbl
    }()
    
    @objc func didTapBackgroundView(){
        
    }
    @objc func clickLeftBtn(){
        
    }
    @objc func clickRightBtn(){
        
    }
}
