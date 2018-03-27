//
//  ChatEmoji.swift
//  Chat
//
//  Created by yaxun on 2018/3/21.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit
import ObjectMapper

struct ChatEmoji : Mappable{
    var img : String = ""
    var title : String = ""
    
    mutating func mapping(map: Map) {
        img <- map["img"]
        title <- map["title"]
        
    }
    
    init?(map: Map) {
        mapping(map: map)
    }
    
}

struct ChatEmojes : Mappable {
    var icon : String = ""
    var list : [ChatEmoji] = []
    
    
    mutating func mapping(map: Map) {
        icon <- map["icon"]
        list <- map["list"]
        
    }
    
    init?(map: Map) {
        mapping(map: map)
    }
    
}
