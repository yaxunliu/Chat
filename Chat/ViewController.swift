//
//  ViewController.swift
//  Chat
//
//  Created by yaxun on 2018/3/16.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    @IBAction func collectionNodeAction(_ sender: UIButton) {
        navigationController?.pushViewController(ChatViewController.init(title :"hello"), animated: true)
    }
    @IBAction func collectionViewAction(_ sender: UIButton) {
        navigationController?.pushViewController(TestViewController(), animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }
}
