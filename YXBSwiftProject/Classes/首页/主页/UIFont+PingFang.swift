//
//  UIFont+PingFang.swift
//  voice
//
//  Created by Mac on 2023/3/21.
//

import Foundation

extension UIFont {
    enum FontWeightStyle {
        case light, semibold, medium, regular, thin, ultralight
    }
    
    static func pingFang(fontSize: CGFloat, style: FontWeightStyle = .regular) -> UIFont {
        var fontName: String?
        var fontWeight: UIFont.Weight?
        
        switch style {
        case .light:
            fontName = "PingFangSC-Light"
            fontWeight = .light
        case .semibold:
            fontName = "PingFangSC-Semibold"
            fontWeight = .semibold
        case .medium:
            fontName = "PingFangSC-Medium"
            fontWeight = .medium
        case .thin:
            fontName = "PingFangSC-Thin"
            fontWeight = .thin
        case .ultralight:
            fontName = "PingFangSC-Ultralight"
            fontWeight = .ultraLight
            
        default:
            fontName = "PingFangSC-Regular"
            fontWeight = .regular
        }
        
        let font = UIFont(name: fontName!, size: fontSize)
        
        if let f = font {
            return f
        } else {
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight!)
        }
    }
}
