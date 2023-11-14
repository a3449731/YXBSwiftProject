//
//  LQMeesageShangMaiCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/10.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import YYText

/// 上麦
class LQMeesageShangMaiCell: LQMessageCell {
        
    let gradientView = {
        let view = GradientView()
        view.backgroundColor = UIColor(hex: 0x000000, transparency: 0.2)
        view.cornerRadius = 7
        return view
    }()
    
    // 内容, 内容的约束也通过实际去调整好了
    let titleLabel: YYLabel = {
        let yyLabel = YYLabel()
        yyLabel.preferredMaxLayoutWidth = 200
        yyLabel.numberOfLines = 0
        yyLabel.lineBreakMode = .byTruncatingTail
        return yyLabel
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
        // 下面都是富文本
        let att: NSMutableAttributedString = NSMutableAttributedString()
        
        let nickAtt = NSMutableAttributedString(string: model.name ?? "")
        nickAtt.yy_font = .titleFont_14
        nickAtt.yy_color = .titleColor_red
        att.append(nickAtt)
        
        let tipAtt = NSMutableAttributedString(string: "上麦了")
        tipAtt.yy_font = .titleFont_14
        tipAtt.yy_color = .titleColor_white
        att.append(tipAtt)
        
        self.titleLabel.attributedText = att
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
