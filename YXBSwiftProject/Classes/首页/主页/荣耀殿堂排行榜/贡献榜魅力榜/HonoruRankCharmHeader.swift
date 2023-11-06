//
//  HonoruRankCharmHeader.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//


import UIKit

// MARK: 提供给tableview.header使用的
class HonoruRankCharmHeader: UIView {
    
    weak var delegate: RankListHeaderDelegate?
    
    let backgroundImageView: UIImageView = MyUIFactory.commonImageView(placeholderImage: nil, contentMode: .scaleToFill)
    // 底座
    let seatBottmImageView: UIImageView = MyUIFactory.commonImageView(placeholderImage: nil, contentMode: .scaleAspectFit)
    
    // 头像
    // 第一名
    private lazy var fisrtUserView: HonourRankUserHeaderView = {
        let view = HonourRankUserHeaderView(herderHeight: 70)
        view.header.image = UIImage(named: "CUYuYinFang_login_logo")
        view.header.borderColor = UIColor(hex: 0xFCCF10)
        view.header.borderWidth = 2
        view.nameLabel.text = "虚位以待"
        view.likeButton .setImage(nil, for: .normal)
        view.crownImageView.image = UIImage(named: "mine_rank_first_3")
        view.crownImageView.snp.updateConstraints { make in
            make.top.equalTo(view.header.snp.top).offset(-25)
            make.left.equalTo(view.header.snp.left).offset(-11)
            make.width.height.equalTo(44)
        }
        return view
    }()
    
    // 第二名
    private lazy var secondUserView: HonourRankUserHeaderView = {
        let view = HonourRankUserHeaderView(herderHeight: 62)
        view.header.image = UIImage(named: "CUYuYinFang_login_logo")
        view.header.borderColor = UIColor(hex: 0xD2E6FF)
        view.header.borderWidth = 2
        view.nameLabel.text = "虚位以待"
        view.likeButton .setImage(nil, for: .normal)
        view.crownImageView.image = UIImage(named: "mine_rank_second_3")
        view.crownImageView.snp.updateConstraints { make in
            make.top.equalTo(view.header.snp.top).offset(-25)
            make.left.equalTo(view.header.snp.left).offset(-11)
            make.width.height.equalTo(44)
        }
        return view
    }()
    
    // 第三名
    private lazy var thirdUserView: HonourRankUserHeaderView = {
        let view = HonourRankUserHeaderView(herderHeight: 62)
        view.header.image = UIImage(named: "CUYuYinFang_login_logo")
        view.header.borderColor = UIColor(hex: 0xEBEBEB)
        view.header.borderWidth = 2
        view.nameLabel.text = "虚位以待"
        view.likeButton .setImage(nil, for: .normal)
        view.crownImageView.image = UIImage(named: "mine_rank_thired_3")
        view.crownImageView.snp.updateConstraints { make in
            make.top.equalTo(view.header.snp.top).offset(-25)
            make.left.equalTo(view.header.snp.left).offset(-11)
            make.width.height.equalTo(44)
        }
        return view
    }()
    
    init(frame: CGRect, page: HonourRankTypeTag) {
        super.init(frame: frame)
        self.addSubview(backgroundImageView)
        self.addSubview(seatBottmImageView)
        seatBottmImageView.addSubview(secondUserView)
        seatBottmImageView.addSubview(thirdUserView)
        seatBottmImageView.addSubview(fisrtUserView)
        fisrtUserView.isUserInteractionEnabled = true
        secondUserView.isUserInteractionEnabled = true
        thirdUserView.isUserInteractionEnabled = true
        
        fisrtUserView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickFirstHeaderAction(_:))))
        secondUserView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickSecondHeaderAction(_:))))
        thirdUserView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickThirdHeaderAction(_:))))
        
        switch page {
        case .contribute:
            fisrtUserView.likeButton.setTitleColor(UIColor(hex: 0xD072E1), for: .normal)
            secondUserView.likeButton.setTitleColor(UIColor(hex: 0xD072E1), for: .normal)
            thirdUserView.likeButton.setTitleColor(UIColor(hex: 0xD072E1), for: .normal)
            backgroundImageView.image = UIImage(named: "honour_contribute_head_background")
            seatBottmImageView.image = UIImage(named: "honour_contribute_seat")
            fisrtUserView.likeButton.setTitle("贡献榜冠军", for: .normal)
        case .charm:
            fisrtUserView.likeButton.setTitleColor(UIColor(hex: 0x8661DE), for: .normal)
            secondUserView.likeButton.setTitleColor(UIColor(hex: 0x8661DE), for: .normal)
            thirdUserView.likeButton.setTitleColor(UIColor(hex: 0x8661DE), for: .normal)
            backgroundImageView.image = UIImage(named: "honour_charm_head_background")
            seatBottmImageView.image = UIImage(named: "honour_charm_seat")
            fisrtUserView.likeButton.setTitle("魅力榜冠军", for: .normal)
        default:
            break
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalToSuperview()
            make.bottom.equalToSuperview()            
        }
        
        seatBottmImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(297.fitScale())
            make.height.equalTo(107.fitScale())
        }
        
        fisrtUserView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.36)
            make.height.equalTo(120)
            make.bottom.equalTo(seatBottmImageView.snp.top).offset(54.fitScale())
        }
        
        secondUserView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(fisrtUserView.snp.left)
            make.height.equalTo(80)
            make.bottom.equalTo(seatBottmImageView.snp.bottom).offset(-45.fitScale())
        }
        
        thirdUserView.snp.makeConstraints { make in
            make.left.equalTo(fisrtUserView.snp.right)
            make.right.equalToSuperview()
            make.height.equalTo(80)
            make.bottom.equalTo(seatBottmImageView.snp.bottom).offset(-45.fitScale())
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
    
    @objc func clickThirdHeaderAction(_ tap: UITapGestureRecognizer) {
        self.delegate?.rankListHeaderDidSelect(index: 2)
        debugPrint("点击了第三名头像")
    }

    public func setupWithModels(models: [HonourRankModel]) {
        if models.first != nil {
            let firstModel = models[0]
            self.fisrtUserView.header.sd_setImage(with: URL(string: firstModel.headImg ?? ""), placeholderImage: UIImage(named: "CUYuYinFang_login_logo"))
            self.fisrtUserView.nameLabel.text = firstModel.nickname
            self.fisrtUserView.likeButton.setTitle("\(firstModel.distanceBefore ?? "")", for: .normal)
            self.fisrtUserView.likeButton.setImage(nil, for: .normal)
        } else {
            self.fisrtUserView.header.image = UIImage(named: "CUYuYinFang_login_logo")
            self.fisrtUserView.nameLabel.text = "虚位以待"
            self.fisrtUserView.likeButton.setTitle("", for: .normal)
        }
        
        if models.count > 1 {
            let secondModel = models[1]
            self.secondUserView.header.sd_setImage(with: URL(string: secondModel.headImg ?? ""), placeholderImage: UIImage(named: "CUYuYinFang_login_logo"))
            self.secondUserView.nameLabel.text = secondModel.nickname
            self.secondUserView.likeButton.setTitle("\(secondModel.distanceBefore ?? "")", for: .normal)
            self.secondUserView.likeButton.setImage(nil, for: .normal)
        } else {
            self.secondUserView.header.image = UIImage(named: "CUYuYinFang_login_logo")
            self.secondUserView.nameLabel.text = "虚位以待"
            self.secondUserView.likeButton.setTitle("", for: .normal)
        }
        
        if models.count > 2 {
            let thirdModel = models[2]
            self.thirdUserView.header.sd_setImage(with: URL(string: thirdModel.headImg ?? ""), placeholderImage: UIImage(named: "CUYuYinFang_login_logo"))
            self.thirdUserView.nameLabel.text = thirdModel.nickname
            self.thirdUserView.likeButton.setTitle("\(thirdModel.distanceBefore ?? "")", for: .normal)
            self.thirdUserView.likeButton.setImage(nil, for: .normal)
        } else {
            self.thirdUserView.header.image = UIImage(named: "CUYuYinFang_login_logo")
            self.thirdUserView.nameLabel.text = "虚位以待"
            self.thirdUserView.likeButton.setTitle("", for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
