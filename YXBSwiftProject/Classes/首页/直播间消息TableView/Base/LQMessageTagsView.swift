//
//  LQMessageTagsView.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/8.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

/// 用户的标签容器，一下字展示
@objc class LQMessageTagsView: UIView {
    
    // 容器
    private lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = self.spacing
        return stackView
    }()
    
    // 间距
    var spacing: CGFloat = 4 {
        didSet {
            hStack.spacing = spacing
        }
    }
    
    // 房
    @objc let houseImageView: UIImageView = {
        let imgView = MyUIFactory.commonImageView(placeholderImage: nil)
        return imgView
    }()
    
    // 管
    @objc let assistantImageView: UIImageView = {
        let imgView = MyUIFactory.commonImageView(placeholderImage: nil)
        return imgView
    }()
    
    // 贵族特效图标，有可能是webp链接
    @objc let nobleImageView: UIImageView = {
        let imgView = MyUIFactory.commonImageView(placeholderImage: nil)
        return imgView
    }()
    
    // 财富等级
    @objc lazy var richView: HonourTagView = {
        let view = HonourTagView()
        view.isHidden = true
        return view
    }()
    
    // 魅力等级
    @objc lazy var charmView: HonourTagView = {
        let view = HonourTagView()
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(hStack)
        hStack.addArrangedSubviews([houseImageView, assistantImageView, nobleImageView, richView, charmView])
        
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        houseImageView.snp.makeConstraints { make in
            make.width.equalTo(16)
        }
        
        assistantImageView.snp.makeConstraints { make in
            make.width.equalTo(16)
        }
        
        richView.snp.makeConstraints { make in
            make.width.equalTo(36)
        }
        
        charmView.snp.makeConstraints { make in
            make.width.equalTo(36)
        }
        
        nobleImageView.snp.makeConstraints { make in
            make.width.equalTo(16)
        }
    }

    // 设置图片
    @objc func setPicturs(houseImageUrl: String?,
                          assistantImageUrl: String?,
                          nobleImageUrl: String?,
                          richImageUrl: String?,
                          charmImageUrl: String?) {
        houseImageView.isHidden = (houseImageUrl == nil || houseImageUrl!.isEmpty)
        assistantImageView.isHidden = (assistantImageUrl == nil || assistantImageUrl!.isEmpty)
        nobleImageView.isHidden = (nobleImageUrl == nil || nobleImageUrl!.isEmpty)
        richView.isHidden = (richImageUrl == nil || richImageUrl!.isEmpty)
        charmView.isHidden = (charmImageUrl == nil || charmImageUrl!.isEmpty)
        
        if let houseImageUrl = houseImageUrl {
            if houseImageUrl.hasPrefix("http") {
                houseImageView.sd_setImage(with: URL(string: houseImageUrl))
            } else {
                houseImageView.image = UIImage(named: houseImageUrl)
            }
        }
        
        if let assistantImageUrl = assistantImageUrl {
            if assistantImageUrl.hasPrefix("http") {
                assistantImageView.sd_setImage(with: URL(string: assistantImageUrl))
            } else {
                assistantImageView.image = UIImage(named: assistantImageUrl)
            }
        }
        
        if let nobleImageUrl = nobleImageUrl {
            if nobleImageUrl.hasPrefix("http") {
                nobleImageView.sd_setImage(with: URL(string: nobleImageUrl))
            } else {
                nobleImageView.image = UIImage(named: nobleImageUrl)
            }
        }
        
        if let richImageUrl = richImageUrl {
            if richImageUrl.hasPrefix("http") {
                richView.imageUrl = richImageUrl
            } else {
                richView.imageName = richImageUrl
            }
        }
        
        if let charmImageUrl = charmImageUrl {
            if charmImageUrl.hasPrefix("http") {
                charmView.imageUrl = charmImageUrl
            } else {
                charmView.imageName = charmImageUrl
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
