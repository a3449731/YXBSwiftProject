//
//  HonourLoveCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/28.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

class HonourLoveCell: UITableViewCell {
            
    var bgView = UIView()
    
    // 光圈
    let leftFlyImgView = MyUIFactory.commonImageView(name: "honour_love_whiteBoard_left", placeholderImage: nil, contentMode: .scaleToFill)
    
    let leftBoardImgView = MyUIFactory.commonImageView(name: "honour_love_left", placeholderImage: nil, contentMode: .scaleToFill)
    
    // 光圈
    let rightFlyImgView = MyUIFactory.commonImageView(name: "honour_love_whiteBoard_right", placeholderImage: nil, contentMode: .scaleToFill)
    
    let rightBoardImgView = MyUIFactory.commonImageView(name: "honour_love_right", placeholderImage: nil, contentMode: .scaleToFill)
    
    let leftImageView: UIImageView = {
        let imgView = MyUIFactory.commonImageView(name: "CUYuYinFang_login_logo", placeholderImage: nil, contentMode: .scaleToFill)
        imgView.cornerRadius = 42.fitScale() / 2
        return imgView
    }()
    
    let rightImageView: UIImageView = {
        let imgView = MyUIFactory.commonImageView(name: "CUYuYinFang_login_logo", placeholderImage: nil, contentMode: .scaleToFill)
        imgView.cornerRadius = 42.fitScale() / 2
        return imgView
    }()
    
    let houseButton: YXBButton = {
        let btn = MyUIFactory.commonImageTextButton(title: "房间名称", titleColor: UIColor(hex: 0x6D729F), titleFont: .subTitleFont_10, image: UIImage(named: "honour_love_house"), space: 4)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    let contentLabel: UILabel = {
        let label = MyUIFactory.commonLabel(text: nil, textColor: UIColor(hex: 0x6B44E1), font: .titleFont_12, lines: 2)
        return label
    }()
    
    
    let tipImageView: UIImageView = {
        let imgView = MyUIFactory.commonImageView(name: "CUYuYinFang_login_logo", placeholderImage: nil, contentMode: .scaleToFill)
        imgView.cornerRadius = 42.fitScale() / 2
        return imgView
    }()
    
    let timeLabel: UILabel = {
        let label = MyUIFactory.commonLabel(text: "10分钟前", textColor: UIColor(hex: 0x6D729F), font: .titleFont_10, lines: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.addSubview(bgView)
        
        bgView.addSubviews([rightFlyImgView, rightBoardImgView, leftFlyImgView, rightImageView, leftBoardImgView, leftImageView, houseButton, contentLabel, tipImageView, timeLabel])

        
        bgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(16.fitScale())
            make.right.equalTo(-16.fitScale())
        }
        
        leftFlyImgView.snp.makeConstraints { make in
            make.centerX.equalTo(leftImageView).offset(-5.fitScale())
            make.centerY.equalTo(leftImageView).offset(-5.fitScale())
            make.width.equalTo(66.fitScale())
            make.height.equalTo(78.fitScale())
        }
        
        leftBoardImgView.snp.makeConstraints { make in
            make.center.equalTo(leftImageView)
            make.width.height.equalTo(46.fitScale())
        }
        
        leftImageView.snp.makeConstraints { make in
            make.left.equalTo(16.fitScale())
            make.centerY.equalToSuperview()
            make.width.height.equalTo(42.fitScale())
        }
        
        rightFlyImgView.snp.makeConstraints { make in
            make.centerX.equalTo(rightImageView).offset(5.fitScale())
            make.centerY.equalTo(rightImageView).offset(-5.fitScale())
            make.width.equalTo(66.fitScale())
            make.height.equalTo(78.fitScale())
        }
        
        rightBoardImgView.snp.makeConstraints { make in
            make.center.equalTo(rightImageView)
            make.width.height.equalTo(46.fitScale())
        }
        
        rightImageView.snp.makeConstraints { make in
            make.left.equalTo(leftImageView.snp.right).offset(-10.fitScale())
            make.centerY.equalToSuperview()
            make.width.height.equalTo(42.fitScale())
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(leftBoardImgView)
            make.right.equalTo(-105)
            make.left.equalTo(rightBoardImgView.snp.right).offset(13)
        }
        
        houseButton.snp.makeConstraints { make in
            make.bottom.equalTo(rightBoardImgView)
//            make.centerX.equalToSuperview()
            make.left.equalTo(contentLabel)
        }
        
        tipImageView.snp.makeConstraints { make in
            make.top.equalTo(3.fitScale())
            make.width.height.equalTo(42.fitScale())
            make.right.equalTo(-15.fitScale())
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(tipImageView.snp.bottom).offset(5)
            make.right.equalTo(tipImageView)            
        }
    }
    
    // MARK: 配置数据
    public func setupWithModel(model: HonourLoveModel, index: Int) {
        self.leftImageView.sd_setImage(with: URL(string: model.fromId?.headImg ?? ""), placeholderImage: UIImage(named: "CUYuYinFang_login_logo"))
        self.rightImageView.sd_setImage(with: URL(string: model.uid?.headImg ?? ""), placeholderImage: UIImage(named: "CUYuYinFang_login_logo"))
        self.contentLabel.attributedText = model.attString
        self.houseButton.setTitle(model.houseName, for: .normal)
        self.tipImageView.sd_setImage(with: URL(string: model.giftUrl ?? ""), placeholderImage: nil)
        self.timeLabel.text = model.rewardDate
    }
    
    //重写高亮
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 1
        } else {
            self.alpha = 1
        }
    }
    //重写选中
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
