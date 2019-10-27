//
//  ViewController.swift
//  JHDatePicker
//
//  Created by Ewan Li on 2019/10/24.
//  Copyright © 2019 Ewan Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
            JHCalendarView.showCalendarView(mutlipleSelect: true, resultBlock: {selectArr in
                NSLog("Select Day \(selectArr)")
            }, cancelBlock: {
                
            })
        })
    }


}

