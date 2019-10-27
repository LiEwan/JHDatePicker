//
//  JHBaseView.swift
//  JHDatePicker
//
//  Created by Ewan Li on 2019/10/27.
//  Copyright © 2019 Ewan Li. All rights reserved.
//

import UIKit

class JHBaseView: UIView {

    func initUI(){
        self.frame = UIScreen.main.bounds
        self.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleBottomMargin.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        self.addSubview(self.backgroundView)
        self.addSubview(self.alertView)
        self.alertView.addSubview(self.headView)
        self.headView.addSubview(self.cancelBtn)
        self.headView.addSubview(self.rightBtn)
        self.headView.addSubview(self.titleLbl)
        self.headView.addSubview(self.lineLbl)
    }
    func setupThemeColor(themeColor:UIColor){
        self.cancelBtn.layer.cornerRadius = 6.0
        self.cancelBtn.layer.borderColor = themeColor.cgColor
        self.cancelBtn.layer.borderWidth = 1.0
        self.cancelBtn.layer.masksToBounds = true
        self.cancelBtn.setTitleColor(themeColor, for: .normal)
        
        self.rightBtn.backgroundColor = themeColor
        self.rightBtn.layer.cornerRadius = 6.0
        self.rightBtn.layer.masksToBounds = true
        self.rightBtn.setTitleColor(UIColor.white, for: .normal)
        self.titleLbl.textColor = themeColor.withAlphaComponent(0.8)
    }
    lazy var backgroundView:UIView = {
        let backgroundView = UIView.init(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        backgroundView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleBottomMargin.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        backgroundView.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(didTapBackgroundView))
        backgroundView.addGestureRecognizer(tapGes)
        return backgroundView
    }()
    lazy var alertView:UIView = {
        let alertView = UIView.init(frame: CGRect(x: 0, y: KScreenH - 260 - bottomHeight, width: KScreenW, height: 260 + bottomHeight))
        alertView.backgroundColor = UIColor.white
        alertView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleTopMargin.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue)
        return alertView
    }()
    
    lazy var headView:UIView = {
        let headView = UIView.init(frame: CGRect(x: 0, y: 0, width: KScreenW, height: 44 + 0.5))
        headView.backgroundColor = HexRGBAlpha(0xfdfdfd,1.0)
        headView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleBottomMargin.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue)
        return headView
    }()
    
    lazy var cancelBtn:UIButton = {
        let cancelBtn = UIButton.createButton("取消", HexRGBAlpha(0x969696,1.0), 15, "")
        cancelBtn.backgroundColor = HexRGBAlpha(0xfdfdfd,1.0)
        cancelBtn.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleBottomMargin.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue)
        cancelBtn.frame = CGRect(x: 5, y: 7, width: 80, height: 30)
        cancelBtn.addTarget(self, action: #selector(clickCancelBtn), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var rightBtn:UIButton = {
        let rightBtn = UIButton.createButton("确定", HexRGBAlpha(0x00bccc,1.0), 15, "")
        rightBtn.backgroundColor = HexRGBAlpha(0xfdfdfd,1.0)
        rightBtn.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleBottomMargin.rawValue | UIView.AutoresizingMask.flexibleLeftMargin.rawValue)
        rightBtn.addTarget(self, action: #selector(clickRightBtn), for: .touchUpInside)
        rightBtn.frame = CGRect(x: self.alertView.frame.size.width - 85, y: 7, width: 80, height: 30)
        return rightBtn
    }()
    lazy var titleLbl:UILabel = {
        let titleLbl = UILabel.init(frame: CGRect(x: 90, y: 0, width: KScreenW - 180 , height: 44))
        titleLbl.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleBottomMargin.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue)
        titleLbl.textColor = HexRGBAlpha(0x969696,1.0)
        titleLbl.textAlignment = NSTextAlignment.center
        return titleLbl
    }()
    
    lazy var lineLbl:UILabel = {
        let lineLbl = UILabel.init(frame: CGRect(x: 0, y: 44, width: KScreenW, height: 0.5))
        lineLbl.backgroundColor = HexRGBAlpha(0xf1f1f1,1.0)
        lineLbl.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleBottomMargin.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue)
        self.alertView.addSubview(lineLbl)
        return lineLbl
    }()
    
    @objc func didTapBackgroundView(){
        
    }
    @objc func clickCancelBtn(){
        
    }
    @objc func clickRightBtn(){
        
    }

}
