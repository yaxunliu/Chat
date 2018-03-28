//
//  UIColor-Extension.swift
//  Chat
//
//  Created by yaxun on 2018/3/22.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func randomColor() -> UIColor {
        let r = arc4random_uniform(256)
        let g = arc4random_uniform(256)
        let b = arc4random_uniform(256)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
    
    convenience init(hex : String) {
        guard let index = hex.index(of: "x") else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
            return
        }
        let start = hex.index(index, offsetBy: 1)
        let rgbStr = hex[start..<hex.endIndex]
        let rStr = rgbStr[rgbStr.startIndex..<rgbStr.index(rgbStr.startIndex, offsetBy: 2)]
        let gStr = rgbStr[rgbStr.index(rgbStr.startIndex, offsetBy: 2)..<rgbStr.index(rgbStr.startIndex, offsetBy: 4)]
        let bStr = rgbStr[rgbStr.index(rgbStr.startIndex, offsetBy: 4)..<rgbStr.endIndex]
        var r : UInt64 = 0x00
        var g : UInt64 = 0x00
        var b : UInt64 = 0x00
        let rscan = Scanner(string: String(rStr))
        rscan.scanHexInt64(&r)
        let gscan = Scanner(string: String(gStr))
        gscan.scanHexInt64(&g)
        let bscan = Scanner(string: String(bStr))
        bscan.scanHexInt64(&b)
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
        
        
    }
    
    
}
