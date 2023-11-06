//
//  HonourRankUserHeaderView.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

// 用户头像， 姓名，喜欢。 这是封装给tableheader中的一部分使用的
class HonourRankUserHeaderView: UIView {
    
    var header: UIImageView = {
        let imageView = MyUIFactory.commonImageView(placeholderImage: nil, contentMode: .scaleToFill)
        return imageView
    }()
    
    var crownImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pingFang(fontSize: 14, style: .semibold)
        label.textColor = .white
        return label
    }()
    lazy var likeButton: YXBButton = {
        let btn = YXBButton(postion: .left, interitemSpace: 2)
        btn.titleLabel?.font = UIFont.pingFang(fontSize: 10, style: .medium)
        btn.setTitleColor(UIColor(hex: 0xCF7018), for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()

//    lazy var topLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = UIFont.pingFang(fontSize: 12, style: .medium)
//        label.textColor = .white
//        return label
//    }()
    
    init(herderHeight: CGFloat) {
        super.init(frame: CGRectZero)
        
        header.cornerRadius = (herderHeight/2)
        self.addSubview(header)
        
        header.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(herderHeight)
        })
        
        self.addSubview(crownImageView)
        crownImageView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.top).offset(-17)
            make.left.equalTo(header.snp.left).offset(-11)
            make.width.height.equalTo(44)
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualTo(0)
            make.right.lessThanOrEqualTo(0)
        }
        
//        self.addSubview(topLabel)
//        topLabel.snp.makeConstraints { make in
//            make.top.equalTo(nameLabel.snp.bottom).offset(2)
//            make.centerX.equalToSuperview()
//            make.left.greaterThanOrEqualToSuperview()
//            make.right.lessThanOrEqualToSuperview()
//        }
        
        self.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
