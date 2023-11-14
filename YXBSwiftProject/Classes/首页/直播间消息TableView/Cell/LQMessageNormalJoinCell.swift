//
//  LQMessageNormalJoinCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/9.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import YYText

/// 普通用户进入，当没有贵族等级时
class LQMessageNormalJoinCell: LQMessageCell {
    
    var model: LQMessageModel?
    
    let gradientView = GradientView()
    
    let iconImageView: UIImageView = {
        let imageView = MyUIFactory.commonImageView(placeholderImage: nil)
        return imageView
    }()

    let titleLbael: YYLabel = {
        let yyLabel = YYLabel()
        yyLabel.preferredMaxLayoutWidth = 200
        yyLabel.numberOfLines = 0
        yyLabel.lineBreakMode = .byTruncatingTail
        return yyLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        creatUI()
    }
    
    private func creatUI() {
        contentBG.addSubviews([gradientView, titleLbael])

        gradientView.cornerRadius(corners: [.allCorners], radius: 15)
        gradientView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.right.equalToSuperview()
        }
        
        titleLbael.snp.makeConstraints { make in
            make.top.equalTo(gradientView.snp.top).offset(9)
            make.left.equalTo(gradientView.snp.left).offset(9)
            make.bottom.equalTo(gradientView.snp.bottom).offset(-9)
            make.right.equalTo(gradientView.snp.right).offset(-9)
        }        
    }
    
    override func setup(model: LQMessageModel) {
        self.model = model
        
        if model.type == .joinRoom || model.type == .follow {
            
//            iconImageView.image = UIImage(named: type.iconName)
//            gradientView.makeGradient([type.endColor, type.startColor], direction: .fromLeftToRight)
                        
            gradientView.backgroundColor = UIColor(hex: 0x000000, transparency: 0.2)
            
            guard let joinRoomAtt = model.joinRoomAtt else {
                return
            }
            
            let att = NSMutableAttributedString(attributedString: joinRoomAtt)                        
            
            // 欢迎按钮，只在加入公会，且没点过欢迎的时候展示
            if model.hasClipWelcome || model.isGh == false {
                
            } else {
                // 创建一个NSMutableAttributedString
                let welcomeImageAtt = NSMutableAttributedString()
                // 创建一个UIImage对象
                let image = UIImage(named: "CUYuYinFang_guizu_join_welcome")
                // 创建一个YYTextAttachment对象，并将UIImage对象添加到YYTextAttachment中
                let attachment = NSMutableAttributedString.yy_attachmentString(withContent: image, contentMode: .center, attachmentSize: image?.size ?? CGSizeMake(10, 10), alignTo: .titleFont_14, alignment: .center)
                // 将YYTextAttachment对象插入到指定位置
                welcomeImageAtt.append(attachment)

                // 为图片添加点击事件
                let highlight: YYTextHighlight = YYTextHighlight()
                highlight.tapAction = { [weak self] containerView, text, range, rect in
                    self?.highlightTapAction(text)
                }
                welcomeImageAtt.yy_setTextHighlight(highlight, range: welcomeImageAtt.yy_rangeOfAll())
                att.append(welcomeImageAtt)
            }
            
            titleLbael.attributedText = att
        }
        
    }
    
    // MARK: 点击了欢迎
    private func highlightTapAction(_ text: NSAttributedString) {
        if let safeModel = self.model {
            self.delegate?.tableView?(cell: self, didTapWellcomeModel: safeModel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
