//
//  Screen+Const.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/12.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import Foundation
//
//  AppScreen.swift
//  voice
//
//  Created by Mac on 2023/3/26.
//

import UIKit

@objc final class ScreenConst: NSObject {
    static let ScreenRatio: CGFloat = ScreenConst.width/375.0
    /// 屏宽
    static let width = UIScreen.main.bounds.size.width
    /// 屏高
    static let height = UIScreen.main.bounds.size.height
    
    static let navBarHeight: CGFloat = 44
    
    /// 是否是刘海屏（notch screen）
    static let hasNotch: Bool = {
        var window: UIWindow?
        
        if #available(iOS 13.0, *){
            window = UIApplication.shared.currentUIWindow()
        } else if #available(iOS 11, *) {
            window = UIApplication.shared.keyWindow
       }
        guard let unwrapedWindow = window else{
            return false
        }
        if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
            return true
        }
       return false
    }()
  
    static let safeAreaInsets: UIEdgeInsets = {
        if #available(iOS 13, *) {
            return UIApplication.shared.currentUIWindow()?.safeAreaInsets ?? UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        } else {
            return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        }
    }()
    
    
    /// 状态栏高度
    static let statusBarHeight: CGFloat  = {
        if #available(iOS 13.0, *) {
            let statusManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
            return statusManager?.statusBarFrame.height ?? 20.0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }()
    
    /// 导航栏+状态栏高度
    static let navStatusBarHeight: CGFloat = {
        return statusBarHeight + navBarHeight
    }()
    
    /// 底部tabBar高度
    static let tabbarHeight: CGFloat = {
        return hasNotch ? 34 + 49 : 49
    }()
    
    /// 底部高度
    static let bottomSpaceHeight: CGFloat = {
        return hasNotch ? 34 : 0
    }()
    
    
    // 获取当前控制器，尤其iOS版本不断升级，加上一些第三方可能乱加window，所以先获取到正确的window是第一步
    @objc static func getCurrentUIController() -> UIViewController? {
        guard let window = UIApplication.shared.getKeyWindow() else {
            return nil
        }
        
        guard let frontView = window.subviews.first else {
            return nil
        }

        guard let nextResponder = frontView.next else {
            return nil
        }
        
        var result: UIViewController?
        if let viewController = nextResponder as? UIViewController {
            result = viewController
        } else {
            result = window.rootViewController

            if let tabBarController = result as? UITabBarController,
               let navigationController = tabBarController.selectedViewController as? UINavigationController {
                result = navigationController.topViewController
            }
        }
        return result
    }
}

extension UIApplication {
    
    /// 找到当前展示的window
    @objc func currentUIWindow() -> UIWindow? {
        if #available(iOS 13.0, *){
            let connectedScenes = UIApplication.shared.connectedScenes
                .filter({
                    $0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
            
            let window = connectedScenes.first?
                .windows
                .first { $0.isKeyWindow }

            return window
        }else{
            return UIApplication.shared.windows.first
        }
    }
    
    /// 找到keyWindow
    @objc func getKeyWindow() -> UIWindow? {
        var keyWindow: UIWindow? = nil
        
        if #available(iOS 13.0, *) {
            let connectedScenes = UIApplication.shared.connectedScenes
            for scene in connectedScenes {
                if let windowScene = scene as? UIWindowScene, scene.activationState == .foregroundActive {
                    for window in windowScene.windows {
                        if window.isKeyWindow {
                            keyWindow = window
                            break
                        }
                    }
                }
            }
        } else {
            keyWindow = UIApplication.shared.keyWindow
        }
        
        return keyWindow
    }
    
//    func navBarHeight() -> CGFloat{ return 44 }
    func statusBarHeight() -> CGFloat {
        guard let window = currentUIWindow() else {
            return 20
        }
        if #available(iOS 13.0, *){
            return window.windowScene?.statusBarManager?.statusBarFrame.height ?? 20
        }else{
            return statusBarFrame.height
        }
    }
    func statusNavBarHeight() -> CGFloat{
        return statusBarHeight() + 44
    }
    func safeAreaBottomHeight() -> CGFloat {
        guard let window = currentUIWindow() else {
            return 0
        }
        if #available(iOS 13.0, *){
            return window.safeAreaInsets.bottom
        }else{
            return windows.first?.safeAreaInsets.bottom ?? 0
        }
    }
    func tabbarHeight() -> CGFloat{
        let tabbarH: CGFloat = 49
        guard let window = currentUIWindow() else {
            return tabbarH
        }
        if #available(iOS 13.0, *){
            return window.safeAreaInsets.bottom + tabbarH
        }else{
            return windows.first?.safeAreaInsets.bottom ?? 0 + tabbarH
        }
    }
}

// 为适配屏幕做的简便写法
extension Numeric {
    func fitScale() -> Self {
        let ratio = CGFloat(truncating: self as! NSNumber) * ScreenConst.ScreenRatio
        return Self(integerLiteral: ratio as! Self.IntegerLiteralType)
    }
}

extension Int {
    func fitScale() -> Self {
        let ratio = CGFloat(self) * ScreenConst.ScreenRatio
        return Int(ratio)
    }
}

extension Double {
    func fitScale() -> Self {
        let ratio = CGFloat(self) * ScreenConst.ScreenRatio
        return Double(ratio)
    }
}
