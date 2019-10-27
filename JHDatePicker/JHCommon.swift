//
//  JHCommon.swift
//  JHDatePicker
//
//  Created by Ewan Li on 2019/10/27.
//  Copyright © 2019 Ewan Li. All rights reserved.
//

import Foundation
import UIKit

enum keyBoardType {
    case scan  /**扫码付款 */
    case receipt /**付款 */
    case refund /**退款 */
}

let encyptKey = "HLF2SYZS.Macbook Pro.AES"
/**
 * 获取屏幕宽
 */
let KScreenW:CGFloat = UIScreen.main.bounds.size.width

let fontScale:CGFloat = KScreenW / 375
/**
 * 获取屏幕高度
 */
let KScreenH:CGFloat = UIScreen.main.bounds.size.height
/**
 * 是否是iPhone X iPhone XS
 */
let isIphoneX_XS:Bool = (KScreenW == 375.0 && KScreenH == 812.0 ? true : false)
/**
 * 是否是iPhone XS Max 或者iPhone XR
 */
let isIphoneXR_XSMax:Bool = (KScreenW == 414 && KScreenH == 896 ? true : false)
/**
 * 是否有刘海
 */
let isFullScreen = (isIphoneX_XS || isIphoneXR_XSMax)
/**
 * 导航栏高度
 */
let TopHeight:CGFloat = (isFullScreen ? 84.0 : 64.0)
/**
 * 底部高度
 */
let bottomHeight:CGFloat = (isFullScreen ? 34.0 : 0.0)
/**
 * 打印
 */
func LRLog<T>(message:T,file: String = #file, _ line: Int = #line){
    let fileName = (file as NSString).lastPathComponent
    print("\(fileName) :[\(line)]  \(message)")
}
/**
 * 设置字体大小
 */
func KFont(_ fontSize:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: fontSize * fontScale)
}
/**
 * 设置图片
 */
let imageNamed:((String) -> UIImage?) = {
    (imageName : String) -> UIImage? in
    return UIImage.init(named: imageName)
}
/**
 * 设置十六进制的颜色
 */
public let HexRGBAlpha:((Int,Float) -> UIColor) = {(rgbValue: Int,alpha: Float) -> UIColor in
    return UIColor(red: CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16) / 255), green: CGFloat(CGFloat((rgbValue & 0xFF00) >> 8) / 255), blue: CGFloat(CGFloat(rgbValue & 0xFF) / 255), alpha: CGFloat(alpha))
}


let CommonColor = HexRGBAlpha(0x21aceb,1.0)
public func base64Encoding(str:String) -> String {
    let strData = str.data(using: String.Encoding.utf8)
    let base64String = strData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
    return base64String!
}

public func base64Decoding(encodedStr:String)->String{
    let decodeData = NSData(base64Encoded: encodedStr, options: NSData.Base64DecodingOptions.init(rawValue: 0))
    let decodedString = NSString(data: decodeData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
    return decodedString
}
