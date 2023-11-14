//
//  LQMessageAiteCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/9.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import YYText

class LQMessageAiteCell: LQMessageBubbleCell {
    // 调整文字的边距
    var titleInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 9, bottom: 5, right: 9) {
        didSet {
            titleLabel.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(titleInset.top)
                make.left.equalToSuperview().offset(titleInset.left)
                make.bottom.equalToSuperview().offset(-titleInset.bottom)
                make.right.lessThanOrEqualTo(-titleInset.right)
            }
        }
    }
    
    // 内容, 内容的约束也通过实际去调整好了
    let titleLabel: YYLabel = {
        let yyLabel = YYLabel()
        yyLabel.preferredMaxLayoutWidth = 180
        yyLabel.numberOfLines = 0
        yyLabel.lineBreakMode = .byTruncatingTail
        return yyLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bubbleBG.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(titleInset.top)
            make.left.equalToSuperview().offset(titleInset.left)
            make.bottom.equalToSuperview().offset(-titleInset.bottom)
            make.right.lessThanOrEqualTo(-titleInset.right)
        }
    }
    
    override func setup(model: LQMessageModel) {
        super.setup(model: model)
        
        // 下面都是富文本
        let att: NSMutableAttributedString = NSMutableAttributedString()
        
        let nickAtt = NSMutableAttributedString(string: model.atText ?? "")
        nickAtt.yy_font = .titleFont_14
        nickAtt.yy_color = .titleColor_yellow
        att.append(nickAtt)
        
        let tipAtt = NSMutableAttributedString(string: "欢迎进入直播间 ")
        tipAtt.yy_font = .titleFont_14
        tipAtt.yy_color = .titleColor_white
        att.append(tipAtt)
        
        self.titleLabel.attributedText = att
        
        // 清空气泡框
        self.bubbleImageView.image = nil
        self.bubbleImageView.cornerRadius = 10
        self.bubbleImageView.backgroundColor = UIColor(hex: 0x000000, transparency: 0.2)
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
