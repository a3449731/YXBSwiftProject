//
//  UIViewController+Navigation.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2020/1/8.
//  Copyright © 2020 -. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    @objc
    public func preferredUsingDismiss() -> Bool {
        return false
    }
    
    @objc 
    public func close(animated: Bool = true, completion: (()->Void)? = nil) {
        let preferredDismiss = preferredUsingDismiss()
        if preferredDismiss {
            if presentingViewController != nil {
                dismiss(animated: animated, completion: completion)
            } else if navigationController?.children.count ?? 0 > 1 {
                CATransaction.animate({
                    navigationController?.popViewController(animated: animated)
                }, completion: completion)
            }
        } else {
            if navigationController?.children.count ?? 0 > 1 {
                CATransaction.animate({
                    navigationController?.popViewController(animated: animated)
                }, completion: completion)
            } else if presentingViewController != nil {
                dismiss(animated: animated, completion: completion)
            }
        }
    }
    
    @objc 
    public func replaceEventually(with viewController: UIViewController, animated: Bool = false, completion: (() -> Void)? = nil) {
        
        // 在 Navigation Controller 中的情况
        if let navCtrl = navigationController {
            if navCtrl.qmui_isPushing || navCtrl.qmui_isPopping {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) { [weak self] in 
                    self?.replaceEventually(with: viewController, animated: animated, completion: completion)
                }
                return
            }
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                var vcs = navCtrl.viewControllers
                if vcs.count >= 2 {
                    vcs.remove(at: vcs.count - 2)
                }
                navCtrl.viewControllers = vcs
                completion?()
            }
            navCtrl.pushViewController(viewController, animated: animated)
            CATransaction.commit()
        }
            // 在 Tabbar Controller 中的情况
        else if let tabCtrl = tabBarController,
            var viewControllers = tabCtrl.viewControllers {
            if let index = viewControllers.firstIndex(of: self) {
                viewControllers.remove(at: index)
                viewControllers.insert(viewController, at: index)
                tabCtrl.viewControllers = viewControllers
                completion?()
            } else {
                //return
            }
        }
            // 被 present 出来的
        else if let vc = presentingViewController {
            if isBeingPresented || isBeingDismissed {
                return
            }
            dismiss(animated: true) { 
                vc.present(viewController, animated: animated, completion: completion)
            }
        }
            // 是 window 的 root controller
        else if view.window?.rootViewController == self {
            view.window?.rootViewController = viewController
            completion?()
        }
            // 被嵌入的 addChild()，这个还需要注意布局问题，暂不实现
        else {
            //return false
        }
        //return true
    }
    
    
    @discardableResult @objc
    public func replace(with viewController: UIViewController, animated: Bool = false, completion: (() -> Void)? = nil) -> Bool {
        
        // 在 Navigation Controller 中的情况
        if let navCtrl = navigationController {
            if navCtrl.qmui_isPushing || navCtrl.qmui_isPopping {
                return false
            }
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                var vcs = navCtrl.viewControllers
                if vcs.count >= 2 {
                    vcs.remove(at: vcs.count - 2)
                }
                navCtrl.viewControllers = vcs
                completion?()
            }
            navCtrl.pushViewController(viewController, animated: animated)
            CATransaction.commit()
        }
        // 在 Tabbar Controller 中的情况
        else if let tabCtrl = tabBarController,
            var viewControllers = tabCtrl.viewControllers {
            if let index = viewControllers.firstIndex(of: self) {
                viewControllers.remove(at: index)
                viewControllers.insert(viewController, at: index)
                tabCtrl.viewControllers = viewControllers
                completion?()
            } else {
                return false
            }
        }
        // 被 present 出来的
        else if let vc = presentingViewController {
            if isBeingPresented || isBeingDismissed {
                return false
            }
            dismiss(animated: true) { 
                vc.present(viewController, animated: animated, completion: completion)
            }
        }
        // 是 window 的 root controller
        else if view.window?.rootViewController == self {
            view.window?.rootViewController = viewController
            completion?()
        }
        // 被嵌入的 addChild()，这个还需要注意布局问题，暂不实现
        else {
            return false
        }
        return true
    }
}
