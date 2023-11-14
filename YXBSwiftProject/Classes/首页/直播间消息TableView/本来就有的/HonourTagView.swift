//
//  SSSSS.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/29.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import Foundation

class HonourTagView: UIView {
    
    public var imageUrl: String = "" {
        didSet {
            sexIconImageView.sd_setImage(with: URL(string: imageUrl))
        }
    }
    
    public var imageName: String = "" {
        didSet {
            sexIconImageView.image = UIImage(named: imageName)
        }
    }
    
    @objc public var title: String = "" {
        didSet {
            self.ageLabel.text = title
        }
    }
    public var titleColor: UIColor? {
        didSet {
            self.ageLabel.textColor = .titleColor_white
        }
    }

    private var sexIconImageView = UIImageView()
    
    private lazy var ageLabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .titleColor_white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.addSubview(sexIconImageView)
        self.addSubview(ageLabel)
        
        sexIconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(36.fitScale())
            make.height.equalTo(18.fitScale())
            make.centerY.equalToSuperview()
        }
        
        ageLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(19.fitScale()).priority(900)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
}
