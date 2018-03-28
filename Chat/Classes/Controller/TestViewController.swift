//
//  TestViewController.swift
//  Chat
//
//  Created by yaxun on 2018/3/28.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "0xF5F5F5")
        let collection = UICollectionView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 150), collectionViewLayout: EmojiFlowLayout())
        collection.dataSource = self
        collection.delegate = self
        collection.isPagingEnabled = true
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collection.backgroundColor = UIColor.white
        view.addSubview(collection)
        
    }


}

extension TestViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 { return 72 }
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
}
