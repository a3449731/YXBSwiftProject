//
//  LQMeesageRoomAnnouncCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/10.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

/// 官方的公告
class LQMeesageRoomAnnouncCell: LQMessageCell {
        
    let gradientView = {
        let view = GradientView()
        view.backgroundColor = UIColor(hex: 0xFF4F73, transparency: 0.2)
        view.cornerRadius = 5
        view.borderWidth = 0.5
        view.borderColor = UIColor(hex: 0xFF4F73)
        return view
    }()
    
    // 内容, 内容的约束也通过实际去调整好了
    var titleLabel: UILabel = {
        let label = MyUIFactory.commonLabel(text: nil, textColor: UIColor(hex: 0x46FBFF), font: .titleFont_11, lines: 0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.edgesInset = UIEdgeInsets(top: 10, left: 15, bottom: 2, right: 10)
        creatUI()
    }
    
    private func creatUI() {
        contentBG.addSubviews([gradientView, titleLabel])

        gradientView.cornerRadius(corners: [.allCorners], radius: 7)
        gradientView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(gradientView.snp.top).offset(5)
            make.left.equalTo(gradientView.snp.left).offset(9)
            make.bottom.equalTo(gradientView.snp.bottom).offset(-5)
            make.right.equalTo(gradientView.snp.right).offset(-9)
        }
    }
    
    override func setup(model: LQMessageModel) {
        self.titleLabel.text = model.text
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
