//
//  LQMessageTextCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/8.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import YYText

/// 文字cell
class LQMessageTextCell: LQMessageBubbleCell {
    
    var model: LQMessageModel?
    
    // 调整文字的边距
    var titleInset: UIEdgeInsets = UIEdgeInsets(top: 15.fitScale(), left: 22.5.fitScale(), bottom: 15.fitScale(), right: 22.5.fitScale()) {
        didSet {
            titleLabel.snp.remakeConstraints { make in
                make.top.equalTo(titleInset.top)
                make.left.equalTo(titleInset.left)
                make.bottom.equalTo(-titleInset.bottom)
            }
        }
    }
    
    // 内容, 内容的约束也通过实际去调整好了
    lazy var titleLabel: YYLabel = {
        let yyLabel = YYLabel()
        yyLabel.font = .titleFont_15
        yyLabel.textColor = .titleColor_white
        yyLabel.preferredMaxLayoutWidth = 182
        yyLabel.numberOfLines = 0
        yyLabel.lineBreakMode = .byWordWrapping
        return yyLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        bubbleBG.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(titleInset.top)
            make.left.equalToSuperview().offset(titleInset.left)
            make.bottom.equalToSuperview().offset(-titleInset.bottom)
        }
    }
    
    
    override func setup(model: LQMessageModel) {
        super.setup(model: model)
        self.model = model
        
        if let qpKuange = model.qpKuang,
           !qpKuange.isEmpty {
            titleInset = UIEdgeInsets(top: 15.fitScale(), left: 22.5.fitScale(), bottom: 15.fitScale(), right: 22.5.fitScale())
        } else {
            titleInset = UIEdgeInsets(top: 5, left: 9, bottom: 5, right: 9)
        }
                
        // 文本内容
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

