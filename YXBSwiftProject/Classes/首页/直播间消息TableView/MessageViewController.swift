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
        
        let tableView = RoomMessageTableView(frame: .zero)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(0)
            make.bottom.equalTo(-100)
            make.width.equalTo(260)
        }
        
        
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}
