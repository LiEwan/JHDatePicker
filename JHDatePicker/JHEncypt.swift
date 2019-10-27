//
//  JHEncypt.swift
//  JHDatePicker
//
//  Created by Ewan Li on 2019/10/27.
//  Copyright © 2019 Ewan Li. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit
extension String{
    var MD5String:String{
        let cStr = cString(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr, CC_LONG(strlen(cStr!)), buffer)
        
        var md5String = ""
        for idx in 0...15 {
            let obcStr = String.init(format: "%02X", buffer[idx])
            md5String.append(obcStr)
        }
        free(buffer)
        return md5String.uppercased()
    }
}

extension UIButton{
    public struct AssociatedKeys{
        static var defaultInterval:TimeInterval = 1.5 // 间隔时间
        static var A_customInterval = "customInterval"
        static var A_ignoreInterval = "ignoreInterval"
    }
    var customInterval:TimeInterval{
        get{
            let A_customInterval = objc_getAssociatedObject(self, &AssociatedKeys.A_customInterval)
            if let time = A_customInterval{
                return time as! TimeInterval
            }else{
                return AssociatedKeys.defaultInterval
            }
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.A_customInterval, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var ignoreInterval:Bool{
        get{
            return (objc_getAssociatedObject(self, &AssociatedKeys.A_ignoreInterval) != nil)
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.A_ignoreInterval, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    public class func initializeMethod(){
        if self == UIButton.self{
            let systemSel = #selector(UIButton.sendAction(_:to:for:))
            let sSel = #selector(UIButton.mySendAction(_:to:for:))
            
            let systemMethod = class_getInstanceMethod(self, systemSel)
            let sMethod = class_getInstanceMethod(self, sSel)
            
            let isTrue = class_addMethod(self, systemSel, method_getImplementation(sMethod!), method_getTypeEncoding(sMethod!))
            
            if isTrue{
                class_replaceMethod(self, sSel, method_getImplementation(systemMethod!), method_getTypeEncoding(systemMethod!))
            }else{
                method_exchangeImplementations(systemMethod!, sMethod!)
            }
        }
    }
    @objc private dynamic func mySendAction(_ action:Selector,to target:Any?,for event:UIEvent?){
        if !ignoreInterval{
            isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + customInterval, execute: {
                self.isUserInteractionEnabled = true
            })
        }
        mySendAction(action, to: target, for: event)
    }
    
    class func createButton(_ title:String,_ titleColor:UIColor,_ font:CGFloat,_ imageName:String) -> UIButton{
        let button = UIButton()
        if imageName.count > 0 {
            button.setImage(imageNamed(imageName), for: .normal)
        }
        button.setTitleColor(titleColor, for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = KFont(font)
        return button
    }
}
extension DispatchQueue {
    private static var onceTracker = [String]()
    public class func once(token: String, block: () -> ()) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if onceTracker.contains(token) {
            return
        }
        onceTracker.append(token)
        block()
    }
}
extension UILabel{
    class func createLabel(_ title:String,_ textColor:UIColor,_ font:CGFloat,_ alignment: NSTextAlignment) -> UILabel{
        let label = UILabel()
        label.textAlignment = alignment
        label.text = title
        label.textColor = textColor
        label.font = KFont(font)
        return label
    }
}

extension UITextField{
    class func createTextField(_ place:String, _ textColor:UIColor,_ font:CGFloat,_ alignment:NSTextAlignment) -> UITextField{
        let textField = UITextField()
        textField.placeholder = place
        textField.textColor = textColor
        textField.font = KFont(font)
        textField.textAlignment = alignment
        return textField
    }
}

extension NSDictionary{
    func hf_objectForKey(_ key:String) -> Any{
        var obj = self.object(forKey: key)
        if obj is NSNull {
            LRLog(message: "There is no value for key\(key)")
            obj = ""
        }
        if (obj == nil) {
            LRLog(message: "Object For key\(key) is NULL")
            obj = ""
        }
        return obj as Any
    }
    func hf_intValueForKey(_ key:String) ->Any{
        for intKey in self.allKeys {
            if intKey as! String == key {
                return self.object(forKey: key) as Any
            }
        }
        return "0" as Any
    }
}
