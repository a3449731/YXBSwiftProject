//
//  HonourCharmCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

class HonourCharmCell: UITableViewCell {
            
    var bgView = UIView()
    
    // 序号
    private lazy var sortLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pingFang(fontSize: 18, style: .semibold)
        label.textColor = UIColor(hex: 0x555555)
        return label
    }()
    
    // 头像
    private lazy var userHeader: UIImageView = {
        let user = UIImageView()
        user.cornerRadius = 23
        user.borderColor = UIColor(hex: 0xE3769D)
        user.borderWidth = 1
        return user
    }()
    
    // 名字
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pingFang(fontSize: 12, style: .medium)
        label.textColor = UIColor(hex: 0x262626)
        return label
    }()
    
    // 喜欢数量
    private lazy var likeButton: YXBButton = {
        let btn = YXBButton(postion: .left, interitemSpace: 4)
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = UIFont.pingFang(fontSize: 10, style: .medium)
        btn.setTitleColor(UIColor(hex: 0x999999), for: .normal)
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
        
        self.contentView.addSubview(bgView)
        bgView.addSubview(sortLabel)
        bgView.addSubview(userHeader)
        bgView.addSubview(userNameLabel)
        bgView.addSubview(likeButton)
        bgView.addSubview(topLabel)
        
        bgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        sortLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        userHeader.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(50)
            make.width.height.equalTo(46)
        }
        
        userNameLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(userHeader.snp.centerY)
            make.top.equalTo(userHeader).offset(10)
            make.left.equalTo(userHeader.snp.right).offset(12)
            make.right.equalTo(-100)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-15)
            make.height.equalTo(16)
        }
                
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(1)
            make.right.equalTo(-10)
        }
    }
    
    // MARK: 配置数据
    public func setupWithModel(model: HonourRankModel, index: Int) {
        self.sortLabel.text = model.rank
        self.userHeader.sd_setImage(with: URL(string: model.headImg ?? ""), placeholderImage: UIImage(named: "CUYuYinFang_login_logo"))
        self.userNameLabel.text = model.nickname
        self.likeButton.setTitle("\(model.distanceBefore ?? "")", for: .normal)
        self.likeButton.setImage(UIImage(named: "mine_rank_like_pink"), for: .normal)
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
