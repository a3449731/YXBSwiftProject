//
//  LQMessageNobbleJoinCell.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/9.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import YYText

/// 贵族进入，比较特殊的cell
class LQMessageNobbleJoinCell: LQMessageCell {
    
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
        
        self.edgesInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 40)
        creatUI()
    }
    
    private func creatUI() {
        self.contentView.addSubview(contentBG)
        contentBG.addSubviews([gradientView, iconImageView, titleLbael])
        
        gradientView.cornerRadius(corners: [.allCorners], radius: 15)
        gradientView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.right.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(gradientView).offset(-17)
            make.left.equalTo(gradientView).offset(-10)
            make.width.height.equalTo(54)
        }
        
        titleLbael.snp.makeConstraints { make in
            make.top.equalTo(gradientView.snp.top).offset(5)
            make.left.equalTo(iconImageView.snp.right).offset(4)
            make.right.equalTo(gradientView.snp.right).offset(-10)
            make.bottom.equalTo(gradientView.snp.bottom).offset(-5)
        }
    }
    
    override func setup(model: LQMessageModel) {
        self.model = model
        
        if model.type == .joinRoom,
           let vipLevelInt = model.vipLevelInt,
           let type = NobbleType(rawValue: vipLevelInt) {
            
            iconImageView.image = UIImage(named: type.iconName)
            gradientView.makeGradient([type.endColor, type.startColor], direction: .fromLeftToRight)
            
            // 下面都是富文本
            let att: NSMutableAttributedString = NSMutableAttributedString()
            
            let nickAtt = NSMutableAttributedString(string: model.text ?? "")
            nickAtt.yy_font = .titleFont_14
            nickAtt.yy_color = type.nickColor
            att.append(nickAtt)
            
            let tipAtt = NSMutableAttributedString(string: " 进入了房间 ")
            tipAtt.yy_font = .titleFont_14
            tipAtt.yy_color = .titleColor_white
            att.append(tipAtt)
            
            /*
            var welcomeAtt = NSMutableAttributedString(string: "《欢迎》")
            welcomeAtt.yy_font = .titleFont_14
            welcomeAtt.yy_color = .titleColor_white
            // 设置边框
            let border = YYTextBorder()
            border.strokeWidth = 1 // 边框宽度
            border.strokeColor = .titleColor_white // 边框颜色
//            border.lineStyle = .single // 边框线型
            border.cornerRadius = 5 // 圆角半径
            border.insets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2) // 可选的边框内边距
            welcomeAtt.yy_setTextBackgroundBorder(border, range: welcomeAtt.yy_rangeOfAll())
//            welcomeAtt.yy_rangeOfAll()
//            let protolRange = str.range(of: "《欢迎》", options: .backwards)!
            welcomeAtt.yy_setTextHighlight(welcomeAtt.yy_rangeOfAll(), color: .titleColor_white, backgroundColor: .clear) {[weak self] _, att, _, _ in
                self?.highlightTapAction(att)
            }
            att.append(welcomeAtt)
             */
            
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

// MARK: 为不同贵族配置一些属性
private extension LQMessageNobbleJoinCell {
    enum NobbleType: Int {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        
        var iconName: String {
            switch self {
            case .one: return "CUYuYinFang_guizu_join_1"
            case .two: return "CUYuYinFang_guizu_join_2"
            case .three: return "CUYuYinFang_guizu_join_3"
            case .four: return "CUYuYinFang_guizu_join_4"
            case .five: return "CUYuYinFang_guizu_join_5"
            case .six: return "CUYuYinFang_guizu_join_6"
            case .seven: return "CUYuYinFang_guizu_join_7"
            }
        }
        
        // 渐变起始色
        var startColor: UIColor {
            switch self {
            case .one: return UIColor(hex: 0x89EAE4)!
            case .two: return UIColor(hex: 0xFFC455)!
            case .three: return UIColor(hex: 0x50E1EA)!
            case .four: return UIColor(hex: 0xB7B7FF)!
            case .five: return UIColor(hex: 0x66D4FF)!
            case .six: return UIColor(hex: 0xFF89DD)!
            case .seven: return UIColor(hex: 0xF8A38D)!
            }
        }
        
        // 渐变终止色
        var endColor: UIColor {
            switch self {
            case .one: return UIColor(hex: 0xE5FDFF)!
            case .two: return UIColor(hex: 0xFFF7F5)!
            case .three: return UIColor(hex: 0xECF5FF)!
            case .four: return UIColor(hex: 0xF9F9FF)!
            case .five: return UIColor(hex: 0xD4F3FF)!
            case .six: return UIColor(hex: 0xFFF3FF)!
            case .seven: return UIColor(hex: 0xFFF3F0)!
            }
        }
        
        // 渐变终止色
        var nickColor: UIColor {
            switch self {
            case .one: return UIColor(hex: 0x17A2D0)!
            case .two: return UIColor(hex: 0xFF935C)!
            case .three: return UIColor(hex: 0x269BFC)!
            case .four: return UIColor(hex: 0x8E8EF3)!
            case .five: return UIColor(hex: 0x1CA7DD)!
            case .six: return UIColor(hex: 0xFA45C9)!
            case .seven: return UIColor(hex: 0xEB7556)!
            }
        }
    }
}
