//
//  ChatEmojiVM.swift
//  Chat
//
//  Created by yaxun on 2018/3/21.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit
import RxSwift

class ChatEmojiVM: NSObject {

    var emojis : PublishSubject<[ChatEmojes]> = PublishSubject<[ChatEmojes]>()
    
    func loadEmojis()  {
        guard let  path = Bundle.main.path(forResource: "emojies", ofType: "plist", inDirectory: nil) else { return }
        guard let dict = NSDictionary(contentsOfFile: path) else { return }
        let rootDict = dict as! [String:Dictionary<String, Any>]
        guard let emojiDict = rootDict["emoji"] else { return }
        guard let gifDict = rootDict["gifEmoji"] else { return }

        guard let pngEmoji = ChatEmojes(JSON: emojiDict) else { return }
        guard let gifEmoji = ChatEmojes(JSON: gifDict) else { return }
        emojis.onNext([pngEmoji,gifEmoji])
    }
}
