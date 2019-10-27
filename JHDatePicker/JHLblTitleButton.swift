//
//  JHLblTitleButton.swift
//  JHDatePicker
//
//  Created by Ewan Li on 2019/10/27.
//  Copyright © 2019 Ewan Li. All rights reserved.
//

import UIKit

class JHLblTitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class public func jhLblTitleButtonWithTitle(title:String,msg:String) -> JHLblTitleButton{
        let button = self.init()
        button.titleLbl.text = title
        button.solarLbl.text = msg
        return button
    }
    private func setupUI(){
        self.addSubview(self.titleLbl)
        self.addSubview(self.solarLbl)
    }
    lazy var titleLbl: UILabel = {
        let lbl = UILabel.createLabel("", HexRGBAlpha(0x252525,1.0), 14, .center)
        lbl.frame = CGRect(x: 0, y: 10, width: btnW, height: 15)
        return lbl
    }()
    lazy var solarLbl:UILabel = {
        let lbl = UILabel.createLabel("", HexRGBAlpha(0x252525,1.0), 11, .center)
        lbl.frame = CGRect(x: 0, y: 25, width: btnW, height: 15)
        return lbl
    }()

}
