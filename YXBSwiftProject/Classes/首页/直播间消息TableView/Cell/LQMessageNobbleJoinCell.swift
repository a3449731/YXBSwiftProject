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
class LQMessageNobbleJoinCell: LQOnlyBubbleCell {
    
    var model: LQMessageModel?
        
    // 调整文字的边距
    var titleInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 9, bottom: 5, right: 4) {
        didSet {
            titleLabel.snp.remakeConstraints { make in
                make.top.equalTo(titleInset.top)
                make.left.equalTo(titleInset.left)
                make.bottom.equalTo(-titleInset.bottom)
            }
        }
    }
    
    let iconImageView: UIImageView = {
        let imageView = MyUIFactory.commonImageView(placeholderImage: nil)
        return imageView
    }()

    let titleLabel: YYLabel = {
        let yyLabel = YYLabel()
        yyLabel.preferredMaxLayoutWidth = 180
        yyLabel.numberOfLines = 0
        yyLabel.lineBreakMode = .byWordWrapping
        return yyLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        creatUI()
    }
    
    private func creatUI() {
        self.contentView.addSubview(contentBG)
        bubbleBG.addSubviews([iconImageView, titleLabel])
        
        self.bubbleImageView.cornerRadius = 15
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(bubbleBG)
            make.left.equalTo(bubbleBG).offset(9)
            make.width.height.equalTo(26)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(titleInset.top)
            make.left.equalTo(iconImageView.snp.right).offset(titleInset.left)
            make.bottom.equalToSuperview().offset(-titleInset.bottom)
        }
    }
    
    override func setup(model: LQMessageModel) {
        self.model = model
        
        if model.type == .joinRoom,
           let vipLevelInt = model.vipLevelInt,
           let type = NobbleType(rawValue: vipLevelInt) {
            
            iconImageView.image = UIImage(named: type.iconName)
            bubbleImageView.makeGradient([type.endColor, type.startColor], direction: .fromLeftToRight)
            
            // 下面都是富文本
            let att: NSMutableAttributedString = NSMutableAttributedString()
            
            let nickAtt = NSMutableAttributedString(string: model.nickname ?? "")
            nickAtt.yy_font = .titleFont_14
            nickAtt.yy_color = type.nickColor
            att.append(nickAtt)
            
            let tipAtt = NSMutableAttributedString(string: " 进入了房间")
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
            
            if model.hasClipWelcome || UserConst.isGh == false || UserConst.uid == model.uid {
                
            } else {
                // 创建一个NSMutableAttributedStringc
                let welcomeImageAtt = NSMutableAttributedString()
                welcomeImageAtt.yy_appendString(" ")
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
            
            titleLabel.attributedText = att
        }
        
    }
    
    // MARK: 点击了欢迎
    private func highlightTapAction(_ text: NSAttributedString) {
        if let safeModel = self.model {
            self.delegate?.tableView?(cell: self, didTapWellcomeModel: safeModel)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // MARK: 重要，强制刷新， 这样才能在layoutSubviews拿到titleLabel正确的宽度. 这个地方可以优化一下，只在可见的时候去刷新不可以吗 https://www.jianshu.com/p/9fa58c5febd3
        // 注意是self.contentView，不要写self.setNeedsLayout()，会循环
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
  
//        debugPrint("告诉我这到底执行了多少次", self.titleLabel.frame.size)
        if self.titleLabel.height > 30 {
            iconImageView.snp.remakeConstraints { make in
                make.top.equalTo(bubbleBG).offset(5)
                make.left.equalTo(bubbleBG).offset(9)
                make.width.height.equalTo(26)
            }
        } else {
            iconImageView.snp.remakeConstraints { make in
                make.centerY.equalTo(bubbleBG)
                make.left.equalTo(bubbleBG).offset(9)
                make.width.height.equalTo(26)
            }
        }
        
        // 修改气泡框的大小
        self.bubbleImageView.frame = CGRectMake(0, 0, self.titleLabel.width + titleInset.left + titleInset.right + 40, self.bubbleBG.height)
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
            case .one, .two, .three, .four, .five, .six, .seven: return VipPictureConfig.nobleIcon(level: self.rawValue)!
            }
        }
        
        // 渐变起始色
        var startColor: UIColor {
            switch self {
            case .one: return UIColor(hex: 0x95F9AB)!
            case .two: return UIColor(hex: 0x66D4FF)!
            case .three: return UIColor(hex: 0xFFA26C)!
            case .four: return UIColor(hex: 0xFF81DC)!
            case .five: return UIColor(hex: 0x7AB2FF)!
            case .six: return UIColor(hex: 0xC485F6)!
            case .seven: return UIColor(hex: 0xFB923C)!
            }
        }
        
        // 渐变终止色
        var endColor: UIColor {
            switch self {
            case .one: return UIColor(hex: 0xE9FFEE)!
            case .two: return UIColor(hex: 0xD4F3FF)!
            case .three: return UIColor(hex: 0xFFE6DE)!
            case .four: return UIColor(hex: 0xFFF3FF)!
            case .five: return UIColor(hex: 0xECF4FF)!
            case .six: return UIColor(hex:0xF5EAFF)!
            case .seven: return UIColor(hex: 0xFEDABF)!
            }
        }
        
        // 昵称颜色
        var nickColor: UIColor {
            switch self {
            case .one: return UIColor(hex: 0x4CD569)!
            case .two: return UIColor(hex: 0x1CA7DD)!
            case .three: return UIColor(hex: 0xDE753F)!
            case .four: return UIColor(hex: 0xFF6AD7)!
            case .five: return UIColor(hex: 0x4289ED)!
            case .six: return UIColor(hex: 0xAE61ED)!
            case .seven: return UIColor(hex: 0xE47035)!
            }
        }
    }
}
