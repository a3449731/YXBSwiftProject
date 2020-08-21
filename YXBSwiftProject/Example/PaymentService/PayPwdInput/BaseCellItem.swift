//
//  BaseCellItem.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/27.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation

@objcMembers
open class BaseCellItem: NSObject {
    
    open var reuseId: String
    open var icon: UIImage? = nil
    
    open var title: String? = nil
    open var subtitle: String? = nil
    
    open var detailIcon: String? = nil
    open var detail: String? = nil
    open var detailUrl: String? = nil
    open var detailTintColor: UIColor? = nil
    
    open var bgImg: String? = nil
    open var imgUrl: String? = nil
    open var isSelected: Bool = false
    
    open var height: CGFloat = UITableView.automaticDimension
    
    open var accessoryType = UITableViewCell.AccessoryType.none
    open var selectionStyle = UITableViewCell.SelectionStyle.default
    open var accessoryView: UIView? = nil
    open var userInfo: Any?
    
    open var onSelect: ((BaseCellItem) -> Void)? = nil
    
    public init(reuseId: String = "cell") {
        self.reuseId = reuseId
    }
}
