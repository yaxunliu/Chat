//
//  ChatEmojiKeyboard.swift
//  Chat
//
//  Created by yaxun on 2018/3/20.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import PINRemoteImage



class ChatEmojiKeyboard: ASDisplayNode {
    
    let inset : UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var margin : CGFloat {
        get {
            return 10
        }
    }    
    var emojis : [ChatEmojes]? {
        didSet {
//            collectionNode.reloadData()
        }
    }
    
    fileprivate lazy var collectionNode : ASCollectionNode = {
        let layout = EmojiFlowLayout()
        layout.scrollDirection = .horizontal
        let collecNode = ASCollectionNode(collectionViewLayout: layout)
        collecNode.view.isPagingEnabled = true
        collecNode.dataSource = self
        collecNode.delegate = self
        return collecNode
    }()
    
    override init() {
        super.init()
        setupNode()
        backgroundColor = .white
    }
    
}

extension ChatEmojiKeyboard {
    
    fileprivate func setupNode() {
        addSubnode(self.collectionNode)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        collectionNode.style.preferredSize = CGSize(width: 375, height: 150)
        return ASStackLayoutSpec(direction: .horizontal , spacing: 0, justifyContent: .start, alignItems: .start, children: [collectionNode])
    }
    
}


extension ChatEmojiKeyboard : ASCollectionDataSource,ASCollectionDelegate {
    
    func numberOfSections(in collectionView: ASCollectionNode) -> Int {
        return emojis?.count ?? 0
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        guard let datas = emojis else { return 0}
        let data = datas[section]
        return data.list.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let node = EmojiNode()
//        guard let datas = emojis else { return node }
//        let data = datas[indexPath.section]
        node.view.backgroundColor = UIColor.randomColor()
//        if indexPath.section == 1 {
//            guard let path = Bundle.main.path(forResource: data.list[indexPath.row].img, ofType: nil) else { return node}
//            let data = NSData.init(contentsOfFile: path)! as Data
//            node.imageNode.animatedImage = AnimatedFix.init(gifimage: PINGIFAnimatedImage.init(animatedImageData: data))
//        }else {
//            node.imageNode.image = UIImage.init(named: data.list[indexPath.row].img)
//        }
        return node
    }
}

enum ChatEmojiKeyboardSize : CGFloat {
    case height = 230
    case margin = 25
    case bottomMargin = 80
    case emojiH = 30
}

