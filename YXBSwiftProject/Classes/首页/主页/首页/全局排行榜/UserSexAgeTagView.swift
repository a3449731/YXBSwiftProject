//
//  UserSexAgeTagView.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/26.
//  Copyright © 2023 lixinkeji. All rights reserved.
//


import UIKit
import HandyJSON

// 性别
public enum SexType: Int, HandyJSONEnum {
    case male = 1     // 男
    case female = 2   // 女
    
    var defaultHeaderImage: UIImage? {
        switch self {
        case .male: return UIImage(named: "login_icon_boy")
        case .female: return UIImage(named: "login_icon_girl")
        }
    }
    
    var radarColor: UIColor {
        switch self {
        case .male: return .borderColor_pink
        case .female: return .borderColor_pink
        }
    }
}


// 文件内部使用
fileprivate extension SexType {
    var sexIconName: String {
        switch self {
        case .male: return "mine_sex_boy"
        case .female: return "mine_sex_girl"
        }
    }
    
    var ageColor: UIColor {
        switch self {
        case .male:  return .titleColor
        case .female:  return .subTitleColor
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .male:  return .backgroundColor_gray
        case .female:  return .backgroundColor_white
        }
    }
}

class UserSexAgeTagView: UIView {
    
    public var sex: SexType = .male {
        didSet {
            sexIconImageView.image = UIImage(named: sex.sexIconName)
            self.backgroundColor = sex.backgroundColor
            self.ageLabel.textColor = sex.ageColor
        }
    }
    
    public var age: Int = 0 {
        didSet {
            self.ageLabel.text = age == 0 ? "" : "\(age)"
        }
    }

    private var sexIconImageView = UIImageView()
    
    private lazy var ageLabel = {
        let label = UILabel(frame: .zero)
        label.font = .titleFont_14
        label.textColor = .titleColor
        return label        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.addSubview(sexIconImageView)
        self.addSubview(ageLabel)
        
        sexIconImageView.snp.makeConstraints { make in
            make.size.equalTo(7)
            make.left.equalToSuperview().offset(6)
            make.centerY.equalToSuperview()
        }
        
        ageLabel.snp.makeConstraints { make in
            make.left.equalTo(sexIconImageView.snp.right).offset(2).priority(900)
            make.right.equalToSuperview().offset(-6)
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
