//
//  RankListView.swift
//  voice
//
//  Created by Mac on 2023/4/2.
//

import UIKit
import SDWebImage


// 头像 + OnlineView组合
class OnlineUserView: UIView {
    
    lazy var borderImgView: UIImageView = {
        let imageView = MyUIFactory.commonImageView(placeholderImage: nil)
        return imageView
    }()
    lazy var numberImgView: UIImageView = {
        let imageView = MyUIFactory.commonImageView(placeholderImage: nil)
        return imageView
    }()
    var header: UIImageView = {
        let imageView = MyUIFactory.commonImageView(placeholderImage: nil, contentMode: .scaleToFill)
        return imageView
    }()
    
    init(herderHeight: CGFloat) {
        super.init(frame: CGRectZero)
        
        self.addSubview(borderImgView)
        header.cornerRadius = (herderHeight/2)
        self.addSubview(header)
        self.addSubview(numberImgView)
        
        borderImgView.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
//            make.width.equalTo(137)
//            make.height.equalTo(110)
            make.width.equalTo(herderHeight * 1.47)
            make.height.equalTo(borderImgView.snp.width).multipliedBy(0.8)
        })
        
        header.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(herderHeight)
        })
        
        numberImgView.snp.makeConstraints { make in
            make.bottom.equalTo(borderImgView)
            make.centerX.equalToSuperview()
            if herderHeight > 70 {
                make.width.equalTo(71)
                make.height.equalTo(23)
            } else {
                make.width.equalTo(51)
                make.height.equalTo(18)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 用户头像， 姓名，喜欢。 这是封装给tableheader中的一部分使用的
class OnlineUserLikeView: UIView {
    
    var onlineUser: OnlineUserView?
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
    // 底座
    lazy var bottomSeatImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    // 底座下面有块颜色，第二名 第三名有 第一名没有
    lazy var bottomSeatBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // 距上一名
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.pingFang(fontSize: 12, style: .medium)
        label.textColor = .white
        return label
    }()
    
    init(herderHeight: CGFloat) {
        super.init(frame: CGRectZero)
        
        self.onlineUser = OnlineUserView(herderHeight: herderHeight)
        self.addSubview(onlineUser!)
        onlineUser?.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(herderHeight)
            make.height.equalTo(herderHeight + 20)
        })
        
        self.addSubview(crownImageView)
        crownImageView.snp.makeConstraints { make in
            make.top.equalTo(onlineUser!.header.snp.top).offset(-15)
            make.left.equalTo(onlineUser!.header.snp.left).offset(-15)
            make.width.height.equalTo(38)
        }
        
        // 底座的布局留给外界调整，前三名的位置不太一样
        self.addSubview(bottomSeatImageView)
        self.sendSubviewToBack(bottomSeatImageView)
        bottomSeatImageView.snp.makeConstraints { make in
            make.top.equalTo(onlineUser!.snp.bottom).offset(-40)
            make.left.right.equalTo(0)
            make.bottom.equalTo(47)
        }
        self.addSubview(bottomSeatBackgroundView)
        bottomSeatBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(bottomSeatImageView.snp.top).offset(16)
            make.left.right.equalTo(0)
            make.height.equalTo(16)
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomSeatBackgroundView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualTo(0)
            make.right.lessThanOrEqualTo(0)
        }
        
        self.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        
        self.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
//            make.top.equalTo(topLabel.snp.bottom).offset(1)
//            make.centerX.equalToSuperview()
//            make.left.greaterThanOrEqualToSuperview()
//            make.right.lessThanOrEqualToSuperview()
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
