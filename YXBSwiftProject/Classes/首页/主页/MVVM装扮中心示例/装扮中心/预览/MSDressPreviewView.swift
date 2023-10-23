//
//  MSDressPreviewView.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/21.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import UIKit

class MSDressPreviewView: UIView, DressPreviewProtocol {
    
//    public lazy var effectPreviewLabel: GradientLabel = {
//        let label = GradientLabel()
////        label.makeGradient([UIColor(hex: 0xFE8692), UIColor(hex: 0x447AF6)], direction: .fromLeftToRight)
//        label.textAlignment = .center
//        label.font = UIFont.pingFang(fontSize: 12, style: .regular)
//        label.textColor = .white
//        label.text = "效果预览"
//        return label
//    }()
    
    /// 头像框的view
    public lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = UIFont.pingFang(fontSize: 12, style: .regular)
        label.textColor = UIColor(hex: 0x7E849D)
        label.text = "来挑选个座驾吧~"
        return label
    }()
    
    /// svga的view
    public lazy var effectsView: PlayEffectsView = {
        let view = PlayEffectsView()
        // 只播放一次
//        view.svgaPlayerView.loops = 1
        return view
    }()
    
    public lazy var headerImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    /// 头像框的view
//    public lazy var buyTipLabel: UILabel = {
//        let label = UILabel()
//        label.isHidden = true
//        label.font = UIFont.pingFang(fontSize: 16, style: .regular)
//        label.textColor = .white
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.addSubview(effectPreviewLabel)
        self.addSubview(tipLabel)
        self.addSubview(headerImageView)
        self.addSubview(effectsView)
//        self.addSubview(buyTipLabel)
                
//        effectPreviewLabel.cornerRadius(corners: [UIRectCorner.topRight, UIRectCorner.bottomRight], radius: 13)
//        effectPreviewLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(0)
//            make.left.equalToSuperview()
//            make.width.equalTo(89)
//            make.height.equalTo(26)
//        }
        
        tipLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        effectsView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(110)
        }
        
        headerImageView.cornerRadius = 45
        headerImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(90)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}
