//
//  MessageViewController.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/8.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = RoomMessageTableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalToSuperview()
            make.bottom.equalTo(-100)
            make.right.equalToSuperview()
        }
        
        
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}
