//
//  EmojiFlowLayout.swift
//  Chat
//
//  Created by yaxun on 2018/3/27.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit

class EmojiFlowLayout: UICollectionViewFlowLayout {
    
    var attrs : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    var insert : UIEdgeInsets = UIEdgeInsetsMake(25, 25, 0, 18)
    var normalEmojiW : CGFloat = 27
    var normalEmojiH : CGFloat = 27
    var gifEmojiW : CGFloat = 77
    var gifEmojiH : CGFloat = 40
    var gifInsert : UIEdgeInsets = UIEdgeInsetsMake(25, 30, 0, 30)
    var contentWidth : CGFloat = 0
    
    var normalEmojiMarginTop : CGFloat {
        get {
            guard let height = collectionView?.bounds.height else {return 168}
            return (height - normalEmojiH * 3 - insert.top - insert.bottom) / 2
        }
    }
    
    var normalEmojiMarginRight : CGFloat {
        get {
            let width = UIScreen.main.bounds.width
            return (width - 8 * normalEmojiW - insert.left - insert.right) / 7
        }
    }
    
    var gifEmojiMarginTop : CGFloat {
        get {
            guard let height = collectionView?.bounds.height else {return 168}
            return height - gifEmojiH * 2 - gifInsert.top - gifInsert.bottom
        }
    }
    
    var gifEmojiMarginRight : CGFloat {
        get {
            let width = UIScreen.main.bounds.width
            return (width - 3 * gifEmojiW - gifInsert.left - gifInsert.right) / 2
        }
    }
    
    

    
    
    override func prepare() {
        super.prepare()
        guard let sections = collectionView?.numberOfSections else { return }
        if sections == 0 { return }
        
        for i in 0..<sections {
            if i == 0 { // 普通表情
                print("i == \(i)")
                guard let items = collectionView?.numberOfItems(inSection: 0) else { return }
                for j in 0..<items {
                    let attr : UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: j, section: 0))
                    let frame = caculateNormalEmojiFrame(indexPath: IndexPath(item: j, section: 0))
                    print(NSStringFromCGRect(frame))
                    attr.frame = frame
                    attrs.append(attr)
                }
                let beginPage = items / 24
                let plusPage = items % 24 > 0 ? 1 : 0
                contentWidth = CGFloat((beginPage + plusPage)) * UIScreen.main.bounds.width
            }else { // gif表情
                print("i == \(i)")
                guard let items = collectionView?.numberOfItems(inSection: 1) else { return }
                for j in 0..<items {
                    let attr : UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: j, section: 1))
                    let frame = caculateGifEmojiFrame(indexPath: IndexPath(item: j, section: 1))
                    attr.frame = frame
                    attrs.append(attr)
                }
                let beginPage = items / 6
                let plusPage = items % 6 > 0 ? 1 : 0
                contentWidth += CGFloat((beginPage + plusPage)) * UIScreen.main.bounds.width
            }
        }
        
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrs
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: (collectionView?.bounds.height)!)
    }
    
    
    /// 计算普通emoji所在位置
    fileprivate func caculateNormalEmojiFrame(indexPath : IndexPath) -> CGRect {
        let currentPath = NSIndexPath(item: indexPath.row % 24, section: indexPath.row / 24)
        let x = CGFloat(currentPath.section) * UIScreen.main.bounds.width + CGFloat(currentPath.row % 8) * (normalEmojiW + normalEmojiMarginRight) + insert.left
        let y = CGFloat(currentPath.row / 8) * (normalEmojiH + normalEmojiMarginTop) + insert.top
        return CGRect(x: x, y: y, width: normalEmojiW, height: normalEmojiH)
    }
    
    /// 计算gifEmoji所在位置
    fileprivate func caculateGifEmojiFrame(indexPath : IndexPath) -> CGRect {
        let currentPath = IndexPath(item: indexPath.row % 6, section: indexPath.row / 6)
        let x = contentWidth + CGFloat(currentPath.section) * UIScreen.main.bounds.width + CGFloat(currentPath.row % 3) * (gifEmojiMarginRight + gifEmojiW) + gifInsert.left
        let y = CGFloat(currentPath.row / 3) * (gifEmojiH + gifEmojiMarginTop) + gifInsert.top
        return CGRect(x: x, y: y, width: gifEmojiW, height: gifEmojiH)
    }
    
    
    
    
    
}
