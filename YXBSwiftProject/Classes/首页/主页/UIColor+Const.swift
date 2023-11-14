//
//  UIColor+YXB.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/9/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import SwifterSwift

// 对颜色的配置
extension UIColor {
    // 标题颜色
    public class var titleColor: UIColor {
        UIColor.init(light: UIColor(rgb: 0x222222, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    public class var titleColor_black: UIColor {
        UIColor.init(light: UIColor(rgb: 0x000000, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    public class var titleColor_white: UIColor {
        UIColor.init(light: UIColor(rgb: 0xFFFFFF, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    public class var titleColor_pink: UIColor {
        UIColor.init(light: UIColor(rgb: 0xFF4E73, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    public class var titleColor_yellow: UIColor {
        UIColor.init(light: UIColor(rgb: 0xF5CE70, alpha: 1), dark: UIColor(rgb: 0xF5CE70, alpha: 1))
    }
    
    public class var titleColor_cyan: UIColor {
        UIColor.init(light: UIColor(rgb: 0xC1FEE3, alpha: 1), dark: UIColor(rgb: 0xC1FEE3, alpha: 1))
    }
    
    public class var titleColor_red: UIColor {
        UIColor.init(light: UIColor(rgb: 0xFF4F73, alpha: 1), dark: UIColor(rgb: 0xFF4F73, alpha: 1))
    }
            
    // 副标题颜色
    public class var subTitleColor: UIColor {
        UIColor.init(light: UIColor(rgb: 0x666666, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    public class var subTitleColor_black: UIColor {
        UIColor.init(light: UIColor(rgb: 0x000000, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    // 占位符颜色
    public class var placeHolderColor: UIColor {
        UIColor.init(light: UIColor(rgb: 0xAAAAAA, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    // 背景色
    public class var backgroundColor: UIColor {
        UIColor.init(light: UIColor(rgb: 0xF9F9F9, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    public class var backgroundColor_main: UIColor {
        UIColor.init(light: UIColor(rgb: 0xFF4F73, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    
    public class var backgroundColor_white: UIColor {
        UIColor.init(light: UIColor(rgb: 0xFFFFFF, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    public class var backgroundColor_small_pink: UIColor {
        UIColor.init(light: UIColor(rgb: 0xFFF5F7, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    public class var backgroundColor_gray: UIColor {
        UIColor.init(light: UIColor(rgb: 0xF8F9FD, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
        
    // 边框颜色
    public class var borderColor_pink: UIColor {
        UIColor.init(light: UIColor(rgb: 0xFF4F74, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    public class var borderColor_gray: UIColor {
        UIColor.init(light: UIColor(rgb: 0xEDEDED, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    // 渐变色
    public class var gradientColor_redStart: UIColor {
        UIColor.init(light: UIColor(rgb: 0xFF4D73, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    public class var gradientColor_redEnd: UIColor {
        UIColor.init(light: UIColor(rgb: 0xFF879F, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }
    
    // 提示条
    public class var indicatorColor_black: UIColor {
        UIColor.init(light: UIColor(rgb: 0x000000, alpha: 1), dark: UIColor(rgb: 0x121212, alpha: 1))
    }

}

extension UIColor {
    convenience init(rgb: UInt32, alpha: CGFloat) {
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
//        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}


//+ (UIColor *)colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha {
//    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
//                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
//                            blue:(rgbValue & 0xFF) / 255.0f
//                           alpha:alpha];
//}
