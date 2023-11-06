//
//  RankListHeader.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/26.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import UIKit

protocol RankListHeaderDelegate: NSObjectProtocol {
    func rankListHeaderDidSelect(index: Int)
}

// MARK: 提供给tableview.header使用的
class RankListHeader: UIView {
    
    weak var delegate: RankListHeaderDelegate?
    
    // 头像
    // 第一名
    private lazy var fisrtUserView: OnlineUserLikeView = {
        let view = OnlineUserLikeView(herderHeight: 93)
        view.onlineUser?.header.image = UIImage(named: "mine_rank_header_default")
        view.onlineUser?.borderImgView.image = UIImage(named: "rank_borderImg_1")
        view.onlineUser?.numberImgView.image = UIImage(named: "rank_numberImg_1")
        view.bottomSeatImageView.image = UIImage(named: "rank_siteImg_1")
        view.nameLabel.text = "虚位以待"
//        view.likeButton.setTitle("0", for: .normal)
        view.likeButton .setImage(UIImage(named: "mine_rank_like_white"), for: .normal)
        view.crownImageView.image = UIImage(named: "mine_rank_first_3")
        view.crownImageView.snp.updateConstraints { make in
            make.top.equalTo(view.onlineUser!.header.snp.top).offset(-25)
            make.left.equalTo(view.onlineUser!.header.snp.left).offset(-19)
            make.width.equalTo(51)
            make.height.equalTo(52)
        }
//        view.topLabel.text = "超第二名"
        return view
    }()
    
    // 第二名
    private lazy var secondUserView: OnlineUserLikeView = {
        let view = OnlineUserLikeView(herderHeight: 62)
        view.onlineUser?.header.image = UIImage(named: "mine_rank_header_default")
        view.onlineUser?.borderImgView.image = UIImage(named: "rank_borderImg_2")
        view.onlineUser?.numberImgView.image = UIImage(named: "rank_numberImg_2")
        view.bottomSeatImageView.image = UIImage(named: "rank_siteImg_2")
        view.nameLabel.text = "虚位以待"
//        view.likeButton.setTitle("0", for: .normal)
        view.likeButton .setImage(UIImage(named: "mine_rank_like_white"), for: .normal)
        view.crownImageView.image = UIImage(named: "mine_rank_second_3")
//        view.topLabel.text = "距第一名"
        return view
    }()
    
    // 第三名
    private lazy var thirdUserView: OnlineUserLikeView = {
        let view = OnlineUserLikeView(herderHeight: 62)
        view.onlineUser?.header.image = UIImage(named: "mine_rank_header_default")
        view.onlineUser?.borderImgView.image = UIImage(named: "rank_borderImg_3")
        view.onlineUser?.numberImgView.image = UIImage(named: "rank_numberImg_3")
        view.bottomSeatImageView.image = UIImage(named: "rank_siteImg_3")
        view.nameLabel.text = "虚位以待"
//        view.likeButton.setTitle("0", for: .normal)
        view.likeButton .setImage(UIImage(named: "mine_rank_like_white"), for: .normal)
        view.crownImageView.image = UIImage(named: "mine_rank_thired_3")
//        view.topLabel.text = "距第二名"
        return view
    }()
    
    init(frame: CGRect, page: HomeRankTypeTag) {
        super.init(frame: frame)
                
        self.addSubview(secondUserView)
        self.addSubview(thirdUserView)
        self.addSubview(fisrtUserView)
        fisrtUserView.isUserInteractionEnabled = true
        secondUserView.isUserInteractionEnabled = true
        thirdUserView.isUserInteractionEnabled = true
        
        fisrtUserView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickFirstHeaderAction(_:))))
        secondUserView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickSecondHeaderAction(_:))))
        thirdUserView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickThirdHeaderAction(_:))))
        
        switch page {
        case .rich:
            fisrtUserView.bottomSeatImageView.image = UIImage(named: "rank_siteImg_1")
            secondUserView.bottomSeatImageView.image = UIImage(named: "rank_siteImg_2")
            thirdUserView.bottomSeatImageView.image = UIImage(named: "rank_siteImg_3")            
            fisrtUserView.likeButton.setTitleColor(UIColor(hex: 0xCF7018), for: .normal)
            secondUserView.likeButton.setTitleColor(UIColor(hex: 0xCF7018), for: .normal)
            thirdUserView.likeButton.setTitleColor(UIColor(hex: 0xCF7018), for: .normal)
        case .live:
            fisrtUserView.bottomSeatImageView.image = UIImage(named: "rank_siteImg_1_two")
            secondUserView.bottomSeatImageView.image = UIImage(named: "rank_siteImg_2_two")
            thirdUserView.bottomSeatImageView.image = UIImage(named: "rank_siteImg_3_two")
            fisrtUserView.likeButton.setTitleColor(UIColor(hex: 0x6D81B9), for: .normal)
            secondUserView.likeButton.setTitleColor(UIColor(hex: 0x6D81B9), for: .normal)
            thirdUserView.likeButton.setTitleColor(UIColor(hex: 0x6D81B9), for: .normal)
        case .party:
            fisrtUserView.bottomSeatImageView.image = UIImage(named: "rank_siteImg_1_three")
            secondUserView.bottomSeatImageView.image = UIImage(named: "rank_siteImg_2_three")
            thirdUserView.bottomSeatImageView.image = UIImage(named: "rank_siteImg_3_three")
            fisrtUserView.likeButton.setTitleColor(UIColor(hex: 0xB15393), for: .normal)
            secondUserView.likeButton.setTitleColor(UIColor(hex: 0xB15393), for: .normal)
            thirdUserView.likeButton.setTitleColor(UIColor(hex: 0xB15393), for: .normal)
        }
        
        fisrtUserView.snp.makeConstraints { make in
            make.top.equalTo(55)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.36)
            make.bottom.equalTo(0)
        }
        fisrtUserView.bottomSeatImageView.snp.remakeConstraints { make in
            make.top.equalTo(fisrtUserView.onlineUser!.snp.bottom).offset(-40)
            make.left.right.equalTo(0)
            make.bottom.equalTo(27)
        }
        
        secondUserView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.left.equalToSuperview()
            make.right.equalTo(fisrtUserView.snp.left)
            make.bottom.equalTo(0)
        }
        secondUserView.bottomSeatImageView.snp.remakeConstraints { make in
            make.top.equalTo(secondUserView.onlineUser!.snp.bottom).offset(-25)
            make.left.equalTo(0)
            make.right.equalTo(25);
            make.bottom.equalTo(33)
        }
        
        thirdUserView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.left.equalTo(fisrtUserView.snp.right)
            make.right.equalToSuperview()
            make.bottom.equalTo(0)
        }
        thirdUserView.bottomSeatImageView.snp.remakeConstraints { make in
            make.top.equalTo(thirdUserView.onlineUser!.snp.bottom).offset(-25)
            make.left.equalTo(-25)
            make.right.equalTo(0);
            make.bottom.equalTo(33)
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

    public func setupWithModels(models: [HomeRankModel]) {
        if models.first != nil {
            let firstModel = models[0]
            self.fisrtUserView.onlineUser?.header.sd_setImage(with: URL(string: firstModel.headImg ?? ""), placeholderImage: UIImage(named: "mine_rank_header_default"))
            self.fisrtUserView.nameLabel.text = firstModel.nickname
            self.fisrtUserView.likeButton.setTitle("\(firstModel.distanceBefore ?? "")", for: .normal)
            self.fisrtUserView.likeButton.setImage(UIImage(named: "mine_rank_like_white"), for: .normal)
        } else {
            self.fisrtUserView.onlineUser?.header.image = UIImage(named: "mine_rank_header_default")
            self.fisrtUserView.nameLabel.text = "虚位以待"
            self.fisrtUserView.likeButton.setTitle("", for: .normal)
        }
        
        if models.count > 1 {
            let secondModel = models[1]
            self.secondUserView.onlineUser?.header.sd_setImage(with: URL(string: secondModel.headImg ?? ""), placeholderImage: UIImage(named: "mine_rank_header_default"))
            self.secondUserView.nameLabel.text = secondModel.nickname
            self.secondUserView.likeButton.setTitle("\(secondModel.distanceBefore ?? "")", for: .normal)
            self.secondUserView.likeButton.setImage(UIImage(named: "mine_rank_like_white"), for: .normal)
        } else {
            self.secondUserView.onlineUser?.header.image = UIImage(named: "mine_rank_header_default")
            self.secondUserView.nameLabel.text = "虚位以待"
            self.secondUserView.likeButton.setTitle("", for: .normal)
        }
        
        if models.count > 2 {
            let thirdModel = models[2]
            self.thirdUserView.onlineUser?.header.sd_setImage(with: URL(string: thirdModel.headImg ?? ""), placeholderImage: UIImage(named: "mine_rank_header_default"))
            self.thirdUserView.nameLabel.text = thirdModel.nickname
            self.thirdUserView.likeButton.setTitle("\(thirdModel.distanceBefore ?? "")", for: .normal)
            self.thirdUserView.likeButton.setImage(UIImage(named: "mine_rank_like_white"), for: .normal)
        } else {
            self.thirdUserView.onlineUser?.header.image = UIImage(named: "mine_rank_header_default")
            self.thirdUserView.nameLabel.text = "虚位以待"
            self.thirdUserView.likeButton.setTitle("", for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
