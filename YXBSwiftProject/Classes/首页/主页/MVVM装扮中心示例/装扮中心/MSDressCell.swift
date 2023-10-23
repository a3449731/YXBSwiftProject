//
//  MSDressCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/20.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MSDressCell: UICollectionViewCell {
    private let bgImg: UIImageView = {
        let imageView = MyUIFactory.commonImageView(frame:CGRect(x: 0, y: 0, width: 108.fitScale(), height: 129.fitScale()), name: nil, placeholderImage: nil)
        return imageView
    }()
    
    private let topImg: UIImageView = {
        let imageView = MyUIFactory.commonImageView(frame:CGRect(x: 4.fitScale(), y: 0.fitScale(), width: 100.fitScale(), height: 80.fitScale()), placeholderImage: nil, contentMode: .scaleAspectFit)
        return imageView
    }()
    
    private let nameLab: UILabel = {
        let label = MyUIFactory.commonLabel(frame: CGRect(x: 5.fitScale(), y: 85.fitScale(), width: 100.fitScale(), height: 14.fitScale()), text: nil, textColor: .titleColor_black, font: .titleFont_14, lines: 1, textAlignment: .center)
        return label
    }()
    
    private let timeLab: UILabel = {
        let label = MyUIFactory.commonLabel(frame: CGRect(x: 5.fitScale(), y: 100.fitScale(), width: 100.fitScale(), height: 10.fitScale()), text: nil, textColor: .titleColor_white, font: .subTitleFont_10, lines: 1, textAlignment: .center)
        return label
    }()
    
    private let useLab: UILabel = {
        let label = MyUIFactory.commonLabel(frame: CGRect(x: 3.5.fitScale(), y: 3.5.fitScale(), width: 45.fitScale(), height: 20.fitScale()), text: "装扮中", textColor: .titleColor_white, font: .subTitleFont_10, lines: 1, textAlignment: .center)
        label.backgroundColor = .backgroundColor_main
        label.roundCorners([.topLeft, .bottomRight], radius: 10.fitScale())
        return label
    }()
    
    private let buyLab: UILabel = {
        let label = MyUIFactory.commonLabel(frame: CGRect(x: 5.fitScale(), y: 100.fitScale(), width: 100.fitScale(), height: 10.fitScale()), text: "已购买", textColor: .titleColor_white, font: .subTitleFont_10, lines: 1, textAlignment: .center)
        return label
    }()
    
    private let priceBtn: UIButton = {
        let button = MyUIFactory.commonImageTextButton(title: nil, titleColor: .titleColor_black, titleFont: .titleFont_10, image: UIImage(named: "CUYuYinFang_shangcheng_图层 27")?.scaled(toWidth: 12), postion: .left, space: 2.5.fitScale())
        button.frame = CGRect(x: 5.fitScale(), y: 105.fitScale(), width: 100.fitScale(), height: 20.fitScale())
        button.isUserInteractionEnabled = false
        return button
    }()
    
    var isMyBeiBao: Bool = false
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .backgroundColor_gray
        contentView.cornerRadius = 8
        contentView.addSubview(bgImg)
        bgImg.addSubview(topImg)
        bgImg.addSubview(nameLab)
        bgImg.addSubview(timeLab)
        bgImg.addSubview(useLab)
        bgImg.addSubview(buyLab)
        bgImg.addSubview(priceBtn)
    }
    
    func setup(model: MSDressModel) {
        let image = model.img
        let name = model.name
        let isBuy = model.isyy
        let subs = model.subs
        var price = model.price
        if !subs.isEmpty {
            let subDic = subs[0]
            price = subDic.price
        }
        let time = model.endTime
        
        let isUsed = model.isUsed
        
        topImg.sd_setImage(with: URL(string: image), placeholderImage: nil)
        nameLab.text = name
        
        if isMyBeiBao {
            if time == nil || time!.isEmpty {
                timeLab.text = "永久使用"
            } else {
                if let time = time {
                    let day = Int(time)! / 1000 / 60 / 60 / 24
                    if day > 0 {
                        timeLab.text = "剩余\(day)天"
                    } else {
                        let hour = Int(time)! / 1000 / 60 / 60
                        if hour > 0 {
                            timeLab.text = "剩余(hour)小时"
                        } else {
                            let minute = Int(time)! / 1000 / 60
                            if minute > 0 {
                                timeLab.text = "剩余(minute)分钟"
                                
                            } else {
                                timeLab.text = "已过期"
                            }
                        }
                    }
                }
            }
            buyLab.isHidden = isBuy
            priceBtn.isHidden = true
            useLab.isHidden = !isBuy
        } else {
            timeLab.text = ""
            buyLab.isHidden = true
            priceBtn.isHidden = false
            useLab.isHidden = !isUsed
            priceBtn.setTitle(price, for: .normal)
        }
    }
    
    func configChoose(isSelected: Bool) {
        contentView.borderWidth = isSelected ? 1.0 : 0.0
        contentView.borderColor = isSelected ? .borderColor_pink : .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
