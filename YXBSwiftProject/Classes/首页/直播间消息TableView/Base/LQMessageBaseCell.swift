//
//  LQMessageBaseCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/8.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

class LQMessageBaseCell: LQMessageCell {
    
    private var tempModel: LQMessageModel?
    
    // 头像 + 头像框
    lazy var headerView: HeaderStaticView = {
        let view = HeaderStaticView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHeaderAction))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    // 昵称
    var nameLabel: UILabel = {
        let label = MyUIFactory.commonLabel(text: nil, textColor: .titleColor_white, font: .titleFont_10)
        return label
    }()
    
    // 标签: 房主 + 房管 + 财富等级 + 魅力等级 + 贵族等级
    var tagsView: LQMessageTagsView = {
        let view = LQMessageTagsView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        creatUI()
    }
    
    private func creatUI() {
        
        contentBG.addSubviews([headerView, nameLabel, tagsView])        
        
        headerView.headerImageView.cornerRadius = 16
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(32)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.top).offset(4)
            make.left.equalTo(headerView.snp.right).offset(10)
            make.width.lessThanOrEqualTo(75)
        }
        
        tagsView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(6)            
            // 不用设置右，让内部元素自动撑起来
//            make.right.equalTo(-100)
            make.height.equalTo(16)
        }
        
    }
    
    override func setup(model: LQMessageModel) {
        self.tempModel = model
        
        // 神秘人
        if model.shenmiren_state == "1" {
            self.nameLabel.text = "神秘人"
            self.headerView.setImage(url: "CUYuYinFang_room_shenmiren")
        } else {
            self.nameLabel.text = model.nickname
            self.headerView.setImage(url: model.headImg, headerFrameUrl: model.headKuang, placeholderImage: UIImage(named: "CUYuYinFang_login_logo"))
        }
        
        // 昵称变色
        if model.nichengbianse == "1" {
            self.nameLabel.textColor = UIColor(red: 247/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1)
        } else {
            self.nameLabel.textColor = .titleColor_white
        }
        
        // 几个图标，讲道理我应该在viewModel中取整齐这些的。
        var house: String?
        var assistant: String?
        var rich: String?
        var charm: String?
        var noble: String?
        if model.isFz == "1" {
            house = "lqRoomHostIcon"
        }
        if model.isAdmin == "1" {
            assistant = "lqRoomGuanIcon"
        }
        if let caiLevel = model.caiLevel {
            let level = (Int(caiLevel) ?? -1) > 10 ? 10 : (Int(caiLevel) ?? 0)
            rich = "CUYuYinFang_caifu_level_\(level)"
        }
        if let meiLevel = model.meiLevel {
            let level = (Int(meiLevel) ?? -1) > 10 ? 10 : (Int(meiLevel) ?? 0)
            charm = "CUYuYinFang_renqi_level_\(level)"
        }
        if let vipLevel = model.vipLevel,
           !vipLevel.isEmpty {
            noble = vipLevel
        }
        self.tagsView.richView.title = model.caiLevel ?? ""
        self.tagsView.charmView.title = model.meiLevel ?? ""
        self.tagsView.setPicturs(houseImageUrl: house, assistantImageUrl: assistant, nobleImageUrl: noble, richImageUrl: rich, charmImageUrl: charm)
    }
        
    @objc private func tapHeaderAction() {
        if let model = self.tempModel {
            self.delegate?.tableView?(cell: self, didTapHeaderModel: model)
        }        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
