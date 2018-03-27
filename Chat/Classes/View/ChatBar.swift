//
//  ChatBar.swift
//  Chat
//
//  Created by yaxun on 2018/3/16.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import RxCocoa
import RxSwift

enum ChatBarClickEvent {
    case tapEmoji
    case tapVoice
    case tapMore
}

enum ChatBarKeyBoardType {
    case noneKeyboard
    case moreKeyboard
    case voiceKeyboard
    case emojiKeyboard
}


class ChatBar: ASDisplayNode {
    let chatBarEvent : PublishSubject<ChatBarClickEvent> = PublishSubject<ChatBarClickEvent>.init()
    let keyBoardType : ChatBarKeyBoardType = .noneKeyboard
    
    fileprivate lazy var emojiNode : ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(assetIdentifier: .emoji) , for: .normal)
        node.addTarget(self, action: #selector(emojiClickAction), forControlEvents: .touchDown)
        return node
    }()
    
    fileprivate lazy var moreNode : ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(assetIdentifier: .more) , for: .normal)
        node.addTarget(self, action: #selector(moreClickAction), forControlEvents: .touchDown)
        return node
    }()
    
    fileprivate lazy var voiceNode : ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(assetIdentifier: .voice) , for: .normal)
        node.addTarget(self, action: #selector(voiceClickAction), forControlEvents: .touchDown)
        return node
    }()
    
    fileprivate let inputNode : ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.style.maxSize = CGSize(width: ChatBarDesignPx.editTextMaxW.rawValue, height: ChatBarDesignPx.editTextMaxH.rawValue)
        node.style.minSize = CGSize(width: ChatBarDesignPx.editTextMinW.rawValue, height: ChatBarDesignPx.editTextMinH.rawValue)
        node.style.preferredSize = CGSize(width: ChatBarDesignPx.editTextW.caculate(), height: ChatBarDesignPx.editTextMinH.rawValue)
        node.textContainerInset = UIEdgeInsetsMake(8, 6, 8, 2)
        node.textView.font = UIFont.systemFont(ofSize: 16)
        node.backgroundColor = .white
        node.clipsToBounds = true
        node.cornerRadius = 5
        node.borderColor = UIColor.lightGray.cgColor
        node.borderWidth = 0.5
        
        return node
    }()
    
    override init() {
        super.init()
        self.backgroundColor = UIColor(chatColor: .chatBarBg)
        addSubnode(emojiNode)
        addSubnode(moreNode)
        addSubnode(voiceNode)
        addSubnode(inputNode)
        inputNode.delegate = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let leftHorizontal = ASStackLayoutSpec.horizontal()
        leftHorizontal.justifyContent = .start
        leftHorizontal.alignItems = .end
        leftHorizontal.children = [voiceNode]
        let leftInset = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(ChatBarDesignPx.margin.rawValue, ChatBarDesignPx.margin.rawValue, ChatBarDesignPx.margin.rawValue, ChatBarDesignPx.margin.rawValue), child: leftHorizontal)

        let midHorizontal = ASStackLayoutSpec.horizontal()
        midHorizontal.children = [inputNode]
        midHorizontal.justifyContent = .start
        let midInsert = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(8, 0, 8, 0), child: midHorizontal)
        
        let rightHorizontal = ASStackLayoutSpec.horizontal()
        rightHorizontal.children = [emojiNode,moreNode]
        rightHorizontal.justifyContent = .end
        rightHorizontal.alignItems = .end
        rightHorizontal.spacing = ChatBarDesignPx.margin.rawValue
    
        let rightInset = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(ChatBarDesignPx.margin.rawValue, ChatBarDesignPx.margin.rawValue, ChatBarDesignPx.margin.rawValue, ChatBarDesignPx.margin.rawValue), child: rightHorizontal)
        let stackLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .start, alignItems: .end, children:[leftInset,midInsert,rightInset])
        stackLayout.style.flexShrink = 1.0;
        return stackLayout
    }
    
    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        self.inputNode.frame = context.finalFrame(for: self.inputNode)
    }
    
}


// MARK: editTextNode delegate
extension ChatBar : ASEditableTextNodeDelegate {
    
    /// 文本框已经开始编辑
    func editableTextNodeDidBeginEditing(_ editableTextNode: ASEditableTextNode) {
        print("文本框已经开始编辑")
        
    }
    
    /// 文本框完成编辑
    func editableTextNodeDidFinishEditing(_ editableTextNode: ASEditableTextNode) {
        print("文本框完成编辑")
    }
    /// 文本框内容开始更新
    func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode) {
        let contentSize = inputNode.textView.contentSize
        if contentSize.height == ChatBarDesignPx.editTextMinH.rawValue && inputNode.style.height.value > ChatBarDesignPx.editTextMinH.rawValue {
            inputNode.style.height = ASDimension(unit: .auto, value: ChatBarDesignPx.editTextMinH.rawValue)
        }else if (contentSize.height == ChatBarDesignPx.editTextMinH.rawValue) {
            return
        }
        else if (contentSize.height > ChatBarDesignPx.editTextMaxH.rawValue) {
            inputNode.style.height = ASDimension(unit: .auto, value: ChatBarDesignPx.editTextMaxH.rawValue)
        }
        else {
            inputNode.style.height = ASDimension(unit: .auto, value: contentSize.height)
        }
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: false) {}
        
    }
}
// MARK: 按钮点击事件
extension ChatBar {
    @objc fileprivate func voiceClickAction() {
        self.chatBarEvent.onNext(.tapVoice)
    }
    
    @objc fileprivate func emojiClickAction() {
        self.chatBarEvent.onNext(.tapEmoji)
    }
    
    @objc fileprivate func moreClickAction() {
        self.chatBarEvent.onNext(.tapMore)
    }
    
}


// MARK: chatBar大小的配置
enum ChatBarDesignPx : CGFloat {
    case margin       = 12
    case barHeight    = 50
    case btnImgHeight = 28
    case editTextMinW = 176
    case editTextMaxW = 270
    case editTextMinH = 36
    case editTextMaxH = 136
    case editTextW    = 200
    
    func caculate() -> CGFloat {
        switch self {
        case .editTextW:
            let screenW = UIScreen.main.bounds.width
            return screenW - ChatBarDesignPx.margin.rawValue * 5 - ChatBarDesignPx.btnImgHeight.rawValue * 3
        default:
            return self.rawValue
        }
    }
}


