//
//  UIButton+YXB.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/9/28.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

// MARK: - 防止重复点击
/// 使用示例 btn.preventDoubleTap
extension UIButton {
    private struct AssociatedKeys {
        static var isPreventingDoubleTap = "isPreventingDoubleTap"
    }
    
    var isPreventingDoubleTap: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isPreventingDoubleTap) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isPreventingDoubleTap, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
        
    func preventDoubleTap(interval: TimeInterval = 1.0) {
        isPreventingDoubleTap = true
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) { [weak self] in
            self?.isPreventingDoubleTap = false
        }
    }
    
    override open func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        if isPreventingDoubleTap {
            return
        }
        super.sendAction(action, to: target, for: event)
    }
}
