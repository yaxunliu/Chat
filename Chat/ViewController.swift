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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        present(ChatViewController.init(title :"hello"), animated: true, completion: nil)
        
    }
}
