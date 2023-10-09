//
//  UIColor+YXB.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/9/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Foundation

// 对颜色的配置
extension UIColor {
    // 标题颜色
    public class var titleColor: UIColor {
        UIColor.init(light: UIColor(rgb: 0x222222, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    // 副标题颜色
    public class var subTitleColor: UIColor {
        UIColor.init(light: UIColor(rgb: 0x666666, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    // 占位符颜色
    public class var placeHolderColor: UIColor {
        UIColor.init(light: UIColor(rgb: 0xAAAAAA, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
}
