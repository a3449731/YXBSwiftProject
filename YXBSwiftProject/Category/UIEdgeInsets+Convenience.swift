//
//  UIEdgeInsets+Convenience.swift
//  
//
//  Created by Alex on 2020/2/28.
//  Copyright © 2020 Eric Wu. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    
    static func make(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    func top(_ value: CGFloat) -> UIEdgeInsets {
        var insets = self
        insets.top = value
        return insets
    }
    
    func left(_ value: CGFloat) -> UIEdgeInsets {
        var insets = self
        insets.left = value
        return insets
    }
    
    func bottom(_ value: CGFloat) -> UIEdgeInsets {
        var insets = self
        insets.bottom = value
        return insets
    }
    
    func right(_ value: CGFloat) -> UIEdgeInsets {
        var insets = self
        insets.right = value
        return insets
    }
    
    
    func adding(top: CGFloat) -> UIEdgeInsets {
        var insets = self
        insets.top += top
        return insets
    }
    
    func adding(left: CGFloat) -> UIEdgeInsets {
        var insets = self
        insets.left += left
        return insets
    }
    
    func adding(bottom: CGFloat) -> UIEdgeInsets {
        var insets = self
        insets.bottom += bottom
        return insets
    }
    
    func adding(right: CGFloat) -> UIEdgeInsets {
        var insets = self
        insets.right += right
        return insets
    }
}
