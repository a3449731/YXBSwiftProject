//
//  Toast.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/23.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation
import Toast_Swift

public class Toast: NSObject {
    
    public static var minimumDismissTimeInterval: TimeInterval = 0.5
    public static var maximumDismissTimeInterval: TimeInterval = 5
    
    private static func displayDuration(for string: String) -> TimeInterval {
        let mininum = max(TimeInterval(string.count) * 0.06 + 0.5, minimumDismissTimeInterval)
        return min(mininum, maximumDismissTimeInterval)
    }
    
    public static func showToast(msg: String?, title: String? = nil, position: ToastPosition = .center, in view: UIView? = nil) {
        guard false == CRIsNullOrEmpty(text: msg), let msg = msg else {
            return
        }
        let v = view ?? CRMainWindow() // keyWindow()
        let duration = displayDuration(for: msg + (title ?? ""))
        v.makeToast(msg, duration: duration, position: position, title: title)
    }
    
    @objc 
    @inlinable
    public static func showInfo(_ msg: String?) {
        showInfo(msg, in: nil)
    }
    
    @objc(showInfo:inView:) 
    @inlinable
    public static func showInfo(_ msg: String?, in view: UIView? = nil) {
        showToast(msg: msg, in: view)
    }
    
    @objc 
    @inlinable
    public static func showError(_ msg: String?) {
        showError(msg, in: nil)
    }
    
    @objc(showError:inView:) 
    @inlinable
    public static func showError(_ msg: String?, in view: UIView? = nil) {
        showToast(msg: msg, in: view)
    }
    
    @objc 
    @inlinable
    public static func showSuccess(_ msg: String?) {
        showSuccess(msg, in: nil)
    }
    
    @objc(showSuccess:inView:) 
    @inlinable
    public static func showSuccess(_ msg: String?, in view: UIView? = nil) {
        showToast(msg: msg, in: view)
    }
    
    //MARK: - loading
    
    @objc(showLoadingInView:mask:) 
    @inlinable
    public static func showLoading(in view: UIView? = nil, mask: Bool = true) {
        let v = view ?? keyWindow()
        v.hideToastActivity()
        v.makeToastActivity(.center)
        v.isUserInteractionEnabled = false
    }
    
    @objc(hideLoadingFromView:) 
    @inlinable
    public static func hideLoading(from view: UIView? = nil) {
        let v = view ?? keyWindow()
        v.hideToastActivity()
        v.isUserInteractionEnabled = true
    }
}
