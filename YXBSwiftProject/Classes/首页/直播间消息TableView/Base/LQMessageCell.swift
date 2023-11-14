//
//  LQMessageCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/9.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

class LQMessageCell: UITableViewCell {
    
    weak var delegate: LQMessageCellProtocol?
    
    // 预留一个容器背景，为了能方便调整间距
    let contentBG = UIView()
    
    // 调整容器的边距
    var edgesInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 10) {
        didSet {
            contentBG.snp.remakeConstraints { make in
                make.top.equalTo(edgesInset.top)
                make.left.equalTo(edgesInset.left)
                make.bottom.equalTo(-edgesInset.bottom)
                make.right.equalTo(-edgesInset.right)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        creatUI()
    }
    
    private func creatUI() {
        self.contentView.addSubview(contentBG)
        
        contentBG.snp.makeConstraints { make in
            make.top.equalTo(edgesInset.top)
            make.left.equalTo(edgesInset.left)
            make.bottom.equalTo(-edgesInset.bottom)
            make.right.equalTo(-edgesInset.right)
        }
    }
    
    func setup(model: LQMessageModel) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
