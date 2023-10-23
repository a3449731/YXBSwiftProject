//
//  MyTool.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/9/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

/// 基础控件
struct MyUIFactory {
    
    /// 创建Label, 这样创建节省一点代码行数
    static func commonLabel(frame: CGRect = .zero, text: String?, textColor: UIColor?, font: UIFont? = UIFont.systemFont(ofSize: 14), lines: Int = 1, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.textColor = textColor
        label.font = font
        label.numberOfLines = lines
        label.textAlignment = textAlignment
        return label
    }
    
    /// 创建TwoLineLabel,上下两行文字，间距可以通过verticalSpace调整
    static func commonTwoLineLabel(topText: String?, topFont: UIFont?, topColor: UIColor?,
                                    bottomText: String?, bottomFont: UIFont?, bottomColor: UIColor?) -> TwoLineLabel {
        let label = TwoLineLabel(topText: topText ?? "", bottomText: bottomText ?? "")
        label.topFont = topFont ?? UIFont.systemFont(ofSize: 14)
        label.topColor = topColor ?? .titleColor
        label.bottomFont = bottomFont ?? UIFont.systemFont(ofSize: 14)
        label.bottomColor = bottomColor ?? .subTitleColor
        return label
    }
        
    /// 创建UIImageView, 这样创建节省一点代码行数
    static func commonImageView(frame: CGRect = .zero, name: String? = nil, url: String? = nil, placeholderImage: String?, contentMode: UIView.ContentMode = .scaleToFill) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        if url != nil {
            imageView.sd_setImage(with: URL(string: url!), placeholderImage: (placeholderImage != nil) ? UIImage(named: placeholderImage!) : nil)
        } else {
            imageView.image = (name == nil) ? nil : UIImage(named: name!)
        }
        imageView.contentMode = contentMode
        return imageView
    }
    
    /// 创建UITextField, 这样创建节省一点代码行数
    static func commonTextField(frame: CGRect = .zero, textColor: UIColor?, font: UIFont? = UIFont.systemFont(ofSize: 14), placeHolder: String?, placeHolderColor: UIColor = .placeHolderColor, keyboardType: UIKeyboardType = .default) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.textColor = textColor
        textField.font = font
        textField.placeholder = placeHolder
        textField.setPlaceHolderTextColor(placeHolderColor)
        textField.keyboardType = keyboardType
        return textField
    }
    
    /// 创建UIButton,这样创建节省一点代码行数
    static func commonButton(title: String?, titleColor: UIColor?, titleFont: UIFont?,
                             image: UIImage?, bgColor: UIColor? = nil) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.preventDoubleTap(interval: 1) // 防止重复点击
        btn.setTitle(title, for: .normal)
        btn.setImage(image, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        if let font = titleFont {
            btn.titleLabel?.font = font
        }
        btn.backgroundColor = bgColor
        return btn
    }
    
    
    /// 创建GradientButton,这样创建节省一点代码行数,可以使用渐变色
    static func commonGradientButton(title: String?, titleColor: UIColor?, titleFont: UIFont?,
                             image: UIImage?, bgColor: UIColor? = nil) -> GradientButton {
        let btn = GradientButton(type: .custom)
        btn.preventDoubleTap(interval: 1) // 防止重复点击
        btn.setTitle(title, for: .normal)
        btn.setImage(image, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        if let font = titleFont {
            btn.titleLabel?.font = font
        }
        btn.backgroundColor = bgColor
        return btn
    }
    
    /// 创建TwoLineButton,上下两行文字，间距可以通过verticalSpace调整
    static func commonTwoLineButton(topText: String?, topFont: UIFont?, topColor: UIColor?,
                                    bottomText: String?, bottomFont: UIFont?, bottomColor: UIColor?) -> TwoLineButton {
        let btn = TwoLineButton(topText: topText ?? "", bottomText: bottomText ?? "")
        btn.topFont = topFont ?? UIFont.systemFont(ofSize: 14)
        btn.topColor = topColor ?? .titleColor
        btn.bottomFont = bottomFont ?? UIFont.systemFont(ofSize: 14)
        btn.bottomColor = bottomColor ?? .subTitleColor
        return btn
    }
    
    
    /// 创建图文排列的button，支持图片位置在上下左右
    /// - Parameters:
    ///   - postion: .left , .top, .btoom, .right
    ///   - space: 10
    static func commonImageTextButton(title: String?, titleColor: UIColor?, titleFont: UIFont?,
                                      image: UIImage?, bgColor: UIColor? = nil,
                                      postion: YXBButton.ImagePostion = .left,
                                      space: CGFloat) -> YXBButton {
        let btn = YXBButton(postion: postion, interitemSpace: space)
        btn.setTitle(title, for: .normal)
        btn.setImage(image, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        if let font = titleFont {
            btn.titleLabel?.font = font
        }
        btn.backgroundColor = bgColor
        return btn
    }
}


// MARK: - 倒计时button
extension MyUIFactory {
    static func countDownButton(normal: String, disabled: String) -> YXBCountDownButton {
        let btn = YXBCountDownButton(type: .custom)
        // 注意：second为关键字,相当于占位符，会在运行时替换为秒数，所以可以自定义你想要的文本，如：btn.setTitle("second秒后重试", for: .disabled)
        btn.setTitle(normal, for: .normal)
        btn.setTitle(disabled, for: .disabled)
        return btn
    }
}
