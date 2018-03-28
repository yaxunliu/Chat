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
        let hex = chatColor.rawValue
        self.init(hex: hex)
        
    }
    
    

    
    
    
}




