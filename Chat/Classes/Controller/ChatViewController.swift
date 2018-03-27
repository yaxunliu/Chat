//
//  ChatViewController.swift
//  Chat
//
//  Created by yaxun on 2018/3/16.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import RxSwift

class ChatViewController: ASViewController<ASDisplayNode> {
    
    let chatBar = ChatBar()
    let bag = DisposeBag()
    let emojiVm = ChatEmojiVM()
    
    fileprivate lazy var emojiKeyboard : ChatEmojiKeyboard = {
        let keyboard = ChatEmojiKeyboard()
        keyboard.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: ChatEmojiKeyboardSize.height.rawValue)
        return keyboard
    }()
    
    init(title : String?) {
        super.init(node: ASDisplayNode())
        node.addSubnode(chatBar)
        node.addSubnode(emojiKeyboard)
        
        node.backgroundColor = .red
        node.layoutSpecBlock = { [weak self] node ,constrainedSize in
            let verticalSpec = ASStackLayoutSpec()
            verticalSpec.direction = .vertical
            verticalSpec.children = [(self?.chatBar)!,(self?.emojiKeyboard)!]
            verticalSpec.justifyContent = .end
            verticalSpec.alignItems = .start
            return ASInsetLayoutSpec(insets: UIEdgeInsetsMake(0, 0, 250, 0), child: verticalSpec)
        }    
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeKeyboardNotification()
        observerChatBarEvent()
        bindDataView()
    }
    
}

// MARK: 处理键盘事件
extension ChatViewController {
    
    fileprivate func observeKeyboardNotification()  {
        
        NotificationCenter.default.rx.notification(Notification.Name.UIKeyboardWillChangeFrame).subscribe { (event) in
            guard let notification = event.element else { return }
            guard let userInfo = notification.userInfo else { return }
            guard let endFrame  = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
            let bottomMargin = UIScreen.main.bounds.height - endFrame.minY
            self.node.layoutSpecBlock = { [weak self] node ,constrainedSize in
                let verticalSpec = ASStackLayoutSpec()
                verticalSpec.direction = .vertical
                verticalSpec.children = [(self?.chatBar)!,(self?.emojiKeyboard)!]
                verticalSpec.justifyContent = .end
                verticalSpec.alignItems = .start
                return ASInsetLayoutSpec(insets: UIEdgeInsetsMake(0, 0, bottomMargin, 0), child: verticalSpec)
            }
            self.node.setNeedsLayout()
            self.node.layoutIfNeeded()
        }.disposed(by: bag)
    }
}
// MARK : 处理chatBar交互事件
extension ChatViewController {
    
    fileprivate func observerChatBarEvent () {
        chatBar.chatBarEvent.subscribe { (event) in
            guard let element = event.element else { return }
            self.node.layoutSpecBlock = { [weak self] node ,constrainedSize in
                let verticalSpec = ASStackLayoutSpec()
                verticalSpec.direction = .vertical
                verticalSpec.children = [(self?.chatBar)!,(self?.emojiKeyboard)!]
                verticalSpec.justifyContent = .end
                verticalSpec.alignItems = .start
                return ASInsetLayoutSpec(insets: .zero, child: verticalSpec)
            }
            self.node.setNeedsLayout()
            
            UIView.animate(withDuration: 0.2, animations: {
                self.node.layoutIfNeeded()
            })
            
            
            
            }.disposed(by: bag)
    }
    
    fileprivate func bindDataView() {
        emojiVm.emojis.subscribe { (element) in
            self.emojiKeyboard.emojis = element.element
            
            }.disposed(by: bag)
        
        
        
        emojiVm.loadEmojis()
        
        
        
    }
}


