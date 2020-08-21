//
//  TableViewCellItem.swift
//  GCCX
//
//  Created by Eric Wu on 2019/6/17.
//  Copyright © 2019 Migrsoft Software Inc. All rights reserved.
//

import UIKit

public enum TableViewCellType {
    case normal
    case checkbox
    case radio
    case switchs
    case arrow(_ type: CellArrowType)
    case tags
    case input
    case none

    public enum CellArrowType {
        case arrowOnly// 只有尖头
        case iconArrow // 有箭头带icon
    }
}

class TableViewCellItem: BaseCellItem {
    var cellType: TableViewCellType = .normal
    var keyName = ""
    var detailTitle = ""
    var selected = false

    // MARK: - textField

    var placeholder: String = ""
    var inputValue: String = ""
    var inputLimit: Int = 5
    var keyboardType: UIKeyboardType?
    
    var operation: ((_ item: TableViewCellItem) -> Void)?
}
