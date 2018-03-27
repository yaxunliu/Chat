//
//  ChatImage.swift
//  Chat
//
//  Created by yaxun on 2018/3/18.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit

extension UIImage {
    enum ChatImage : String {
        case more  = "chat_more_btn"
        case emoji = "chat_emoji_btn"
        case voice = "chat_voice_btn"
    }
    
    convenience init!(assetIdentifier : ChatImage) {
        self.init(named: assetIdentifier.rawValue)!

    }
    
}

extension UIColor {
    enum ChatColor : String {
        case chatBarBg = "0xF2F2F2"
        
    }
    
    convenience init!(chatColor : ChatColor) {
        
        guard let index = chatColor.rawValue.index(of: "x") else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
            return
        }
        let start = chatColor.rawValue.index(index, offsetBy: 1)
        let rgbStr = chatColor.rawValue[start..<chatColor.rawValue.endIndex]
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




