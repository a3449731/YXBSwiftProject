//
//  MSDressBuyCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/20.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MSDressBuyCell: UICollectionViewCell {
    private let twoLineBtn: TwoLineButton = {
        let label = MyUIFactory.commonTwoLineButton(topText: nil, topFont: .titleFont_18, topColor: .titleColor_pink, bottomText: nil, bottomFont: .titleFont_14, bottomColor: .titleColor)
        label.isUserInteractionEnabled = false
        label.cornerRadius(corners: [.allCorners], radius: 10.fitScale())
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(twoLineBtn)
        
        twoLineBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setup(model: MSDressBuyShowModel) {
        self.twoLineBtn.topText = model.time ?? ""
        self.twoLineBtn.bottomText = model.priceString ?? ""
    }
    
    func configChoose(isSelected: Bool) {
        
        twoLineBtn.borderWidth = 1
        twoLineBtn.borderColor = isSelected ? .borderColor_pink : .borderColor_gray
        twoLineBtn.backgroundColor = isSelected ? .backgroundColor_small_pink : .backgroundColor_white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
