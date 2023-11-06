//
//  HonourLoveHeaderView.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/28.
//  Copyright © 2023 ShengChang. All rights reserved.
//


import UIKit

// MARK: 提供给tableview.header使用的
class HonourLoveHeaderView: UIView {
    
    weak var delegate: RankListHeaderDelegate?
        
    let backgroundImageView: UIImageView = MyUIFactory.commonImageView(name: "honour_love_chibang", placeholderImage: nil, contentMode: .scaleToFill)
    
    // 光圈
    let leftFlyImgView = MyUIFactory.commonImageView(name: "honour_love_whiteBoard_left", placeholderImage: nil, contentMode: .scaleToFill)
    
    let leftBoardImgView = MyUIFactory.commonImageView(name: "honour_love_left", placeholderImage: nil, contentMode: .scaleToFill)
    
    let leftImageView: UIImageView = {
        let imgView = MyUIFactory.commonImageView(name: "CUYuYinFang_login_logo", placeholderImage: nil, contentMode: .scaleToFill)
        imgView.cornerRadius = 70.fitScale() / 2
        return imgView
    }()
    
    
    // 光圈
    let rightFlyImgView = MyUIFactory.commonImageView(name: "honour_love_whiteBoard_right", placeholderImage: nil, contentMode: .scaleToFill)
    
    let rightBoardImgView = MyUIFactory.commonImageView(name: "honour_love_right", placeholderImage: nil, contentMode: .scaleToFill)
    
    let rightImageView: UIImageView = {
        let imgView = MyUIFactory.commonImageView(name: "CUYuYinFang_login_logo", placeholderImage: nil, contentMode: .scaleToFill)
        imgView.cornerRadius = 70.fitScale() / 2
        return imgView
    }()
    
    let houseButton: YXBButton = {
        let btn = MyUIFactory.commonImageTextButton(title: "房间名称", titleColor: UIColor(hex: 0x6D729F), titleFont: .subTitleFont_10, image: UIImage(named: "honour_love_house"), space: 4)
        return btn
    }()
    
    let middleImageView: UIImageView = {
        let imgView = MyUIFactory.commonImageView(name: "honour_love_give", placeholderImage: nil)
        return imgView
    }()
    
    let leftLabel: UILabel = {
        let label = MyUIFactory.commonLabel(text: nil, textColor: UIColor(hex: 0x6B44E1), font: .titleFont_12, lines: 1, textAlignment: .right)
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = MyUIFactory.commonLabel(text: nil, textColor: UIColor(hex: 0x6B44E1), font: .titleFont_12, lines: 1)
        return label
    }()
    
    let middleLabel: UILabel = {
        let label = MyUIFactory.commonLabel(text: "打赏", textColor: UIColor(hex: 0xFF4D73), font: .titleFont_12, lines: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backgroundImageView)
        addSubviews([leftFlyImgView, leftBoardImgView, rightBoardImgView, rightFlyImgView, leftImageView, rightImageView, houseButton, middleImageView, leftLabel, rightLabel, middleLabel])
        
        leftImageView.isUserInteractionEnabled = true
        rightImageView.isUserInteractionEnabled = true
        
        leftImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickFirstHeaderAction(_:))))
        rightImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickSecondHeaderAction(_:))))
     
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(352.fitScale())
            make.height.equalTo(169.fitScale())
        }
        
        leftFlyImgView.snp.makeConstraints { make in
            make.centerX.equalTo(leftImageView).offset(-10.fitScale())
            make.centerY.equalTo(leftImageView).offset(-8.fitScale())
            make.width.equalTo(99.fitScale())
            make.height.equalTo(118.fitScale())
        }
        
        leftBoardImgView.snp.makeConstraints { make in
            make.center.equalTo(leftImageView)
            make.width.height.equalTo(76.fitScale())
        }
        
        leftImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.75)
            make.centerX.equalToSuperview().multipliedBy(0.65)
            make.width.height.equalTo(70.fitScale())
        }
        
        rightFlyImgView.snp.makeConstraints { make in
            make.centerX.equalTo(rightImageView).offset(10.fitScale())
            make.centerY.equalTo(rightImageView).offset(-8.fitScale())
            make.width.equalTo(99.fitScale())
            make.height.equalTo(118.fitScale())
        }
        
        rightBoardImgView.snp.makeConstraints { make in
            make.center.equalTo(rightImageView)
            make.width.height.equalTo(76.fitScale())
        }
        
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.75)
            make.centerX.equalToSuperview().multipliedBy(1.35)
            make.width.height.equalTo(70.fitScale())
        }
        
        houseButton.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        middleImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(2)
            make.left.equalTo(34)
            make.right.equalTo(-34)
            make.height.equalTo(28.fitScale())
        }
        
        leftLabel.snp.makeConstraints { make in
//            make.top.equalTo(houseButton.snp.bottom).offset(20)
            make.centerY.equalTo(middleImageView)
            make.right.equalTo(leftImageView)
            make.left.equalTo(leftImageView).offset(-10)
        }
        
        rightLabel.snp.makeConstraints { make in
//            make.top.equalTo(houseButton.snp.bottom).offset(20)
            make.centerY.equalTo(middleImageView)
            make.left.equalTo(rightImageView)
            make.right.equalTo(rightImageView).offset(10)
        }
        
        middleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(leftLabel)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func clickFirstHeaderAction(_ tap: UITapGestureRecognizer) {
        self.delegate?.rankListHeaderDidSelect(index: 0)
        debugPrint("点击了第一名头像")
    }
    
    @objc func clickSecondHeaderAction(_ tap: UITapGestureRecognizer) {
        self.delegate?.rankListHeaderDidSelect(index: 1)
        debugPrint("点击了第二名头像")
    }

    public func setupWithModels(model: HonourLoveModel) {
        self.leftImageView.sd_setImage(with: URL(string: model.fromId?.headImg ?? ""), placeholderImage: UIImage(named: "CUYuYinFang_login_logo"))
        self.rightImageView.sd_setImage(with: URL(string: model.uid?.headImg ?? ""), placeholderImage: UIImage(named: "CUYuYinFang_login_logo"))
        self.leftLabel.text = model.fromId?.nickname
        self.rightLabel.text = model.uid?.nickname
        self.houseButton.setTitle(model.houseName, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
