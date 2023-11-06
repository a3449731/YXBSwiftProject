//
//  RankListCell.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/26.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import UIKit

class RankListCell: UITableViewCell {
            
    // 序号
    private lazy var sortLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pingFang(fontSize: 18, style: .medium)
        label.textColor = UIColor(hex: 0x93979A)
        return label
    }()
    
    // 头像
    private lazy var userHeader: OnlineUserView = {
        let user = OnlineUserView(herderHeight: 45)
        return user
    }()
    
    // 名字
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pingFang(fontSize: 14, style: .medium)
        label.textColor = .titleColor
        return label
    }()
    
    // 喜欢数量
    private lazy var likeButton: YXBButton = {
        let btn = YXBButton(postion: .left, interitemSpace: 4)
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = UIFont.pingFang(fontSize: 10, style: .medium)
        btn.setTitleColor(UIColor(hex: 0xB59F99), for: .normal)
        // 关闭交互，触发交给didSelectCell
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    // 距上一名
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pingFang(fontSize: 12, style: .medium)
        label.textColor = .white
//        label.text = "距上一名"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        self.contentView.addSubview(sortLabel)
        sortLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(userHeader)
        userHeader.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(50)
            make.width.height.equalTo(60)
        }
        
        self.contentView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(userHeader.snp.centerY)
            make.top.equalTo(userHeader).offset(10)
            make.left.equalTo(userHeader.snp.right).offset(12)
            make.right.equalTo(-100)
        }
        
        self.contentView.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(3)
            make.left.equalTo(userNameLabel)
//            make.left.equalTo(userNameLabel.snp.right).offset(10)
            make.right.equalTo(-80)
//            make.height.equalToSuperview()
        }
        
        self.contentView.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(1)
            make.right.equalTo(-10)
        }
    }
    
    // MARK: 配置数据
    public func setupWithModel(model: HomeRankModel, index: Int) {
        self.sortLabel.text = model.rank
        self.userHeader.header.sd_setImage(with: URL(string: model.headImg ?? ""), placeholderImage: UIImage(named: "CUYuYinFang_login_logo"))
        self.userNameLabel.text = model.nickname
        self.likeButton.setTitle("\(model.distanceBefore ?? "")", for: .normal)
        self.likeButton.setImage(UIImage(named: "mine_rank_like_pink"), for: .normal)              
    }
    
    //重写高亮
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.45
        } else {
            self.alpha = 1
        }
    }
    //重写选中
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.alpha = 0.45
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
