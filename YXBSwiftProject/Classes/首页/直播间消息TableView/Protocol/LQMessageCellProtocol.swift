//
//  LQMessageCellProtocol.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/10.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Foundation

// 给cell用的协议，倒是不用暴露给objc
@objc protocol LQMessageCellProtocol: NSObjectProtocol {
    // 点击了欢迎
    @objc optional func tableView(cell: LQMessageCell, didTapWellcomeModel: LQMessageModel)
    /// 点击了欢迎
    @objc optional func tableView(cell: LQMessageBaseCell, didTapHeaderModel: LQMessageModel)
}

// 给tableview留的协议，这是要给oc用的。
@objc protocol LQMessageTableViewProtocol: NSObjectProtocol {
    // 点击了欢迎
    @objc optional func tableViewDidTapWellcome(model: LQMessageModel)
    /// 点击了欢迎
    @objc optional func tableViewDidTapHeader(model: LQMessageModel)
}
