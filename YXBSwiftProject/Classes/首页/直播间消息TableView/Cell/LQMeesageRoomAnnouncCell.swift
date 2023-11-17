//
//  LQMeesageRoomAnnouncCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/10.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

/// 官方的公告
class LQMeesageRoomAnnouncCell: LQOnlyBubbleCell {

    var titleInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 9, bottom: 5, right: 9) {
        didSet {
            titleLabel.snp.remakeConstraints { make in
                make.top.equalTo(titleInset.top)
                make.left.equalTo(titleInset.left)
                make.bottom.equalTo(-titleInset.bottom)
            }
        }
    }
    
    // 内容, 内容的约束也通过实际去调整好了
    var titleLabel: UILabel = {
        let label = MyUIFactory.commonLabel(text: nil, textColor: UIColor(hex: 0x46FBFF), font: .titleFont_11, lines: 0)
        label.preferredMaxLayoutWidth = 225
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        creatUI()
    }
    
    private func creatUI() {
        
        self.bubbleImageView.backgroundColor = UIColor(hex: 0xFF4F73, transparency: 0.2)
        self.bubbleImageView.cornerRadius = 7
        self.bubbleImageView.borderWidth = 0.5
        self.bubbleImageView.borderColor = UIColor(hex: 0xFF4F73)
        
        bubbleBG.addSubviews([titleLabel])

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(titleInset.top)
            make.left.equalToSuperview().offset(titleInset.left)
            make.bottom.equalToSuperview().offset(-titleInset.bottom)
        }
    }
    
    override func setup(model: LQMessageModel) {
        self.titleLabel.text = model.text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // MARK: 重要，强制刷新， 这样才能在layoutSubviews拿到titleLabel正确的宽度. 这个地方可以优化一下，只在可见的时候去刷新不可以吗 https://www.jianshu.com/p/9fa58c5febd3
        // 注意是self.contentView，不要写self.setNeedsLayout()，会循环
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
  
//        debugPrint("告诉我这到底执行了多少次", self.titleLabel.frame.size)
        // 修改气泡框的大小
        self.bubbleImageView.frame = CGRectMake(0, 0, self.titleLabel.width + titleInset.left + titleInset.right, self.bubbleBG.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
