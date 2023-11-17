//
//  LQMessageBuddleCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/8.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

class LQMessageBubbleCell: LQMessageBaseCell {
    // 预留一个容器背景，为了能方便调整间距
    let bubbleBG = UIView()
    
    // 调整容器的边距
    var bubbleInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0) {
        didSet {
            bubbleBG.snp.remakeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(bubbleInset.top)
                make.left.equalTo(nameLabel.snp.left).offset(bubbleInset.left)
                make.bottom.equalTo(-bubbleInset.bottom)
                make.right.equalTo(-bubbleInset.right)
            }
        }
    }
    
    // 气泡框,气泡框的大小应该是根据文字宽度来调整拉伸的。
    let bubbleImageView: UIImageView = {
        let imgView = MyUIFactory.commonImageView(placeholderImage: nil)
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bubbleBG.addSubview(bubbleImageView)
        contentBG.addSubview(bubbleBG)
        
        bubbleBG.snp.makeConstraints { make in
//            debugPrint("我要看看这是咋回事", bubbleInset)
            make.top.equalTo(nameLabel.snp.bottom).offset(bubbleInset.top)
            make.left.equalTo(nameLabel.snp.left).offset(bubbleInset.left)
            make.bottom.equalTo(-bubbleInset.bottom)
            make.right.equalTo(-bubbleInset.right)
        }
    }
    
    override func setup(model: LQMessageModel) {
        super.setup(model: model)
        self.bubbleImageView.image = model.bubbleImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
