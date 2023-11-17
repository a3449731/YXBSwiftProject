//
//  LQMessageImageCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/8.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

/// 图片cell
class LQMessageImageCell: LQMessageBaseCell {
    
    var emojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        contentBG.addSubview(emojiImageView)
        
        emojiImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalTo(nameLabel)
            make.width.height.equalTo(70)
            // 为了撑起来cell
            make.bottom.equalTo(-1)
        }
    }
    
    override func setup(model: LQMessageModel) {
        super.setup(model: model)
        
        if let url = model.url {
            self.emojiImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "CUYuYinFang_login_logo"))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
