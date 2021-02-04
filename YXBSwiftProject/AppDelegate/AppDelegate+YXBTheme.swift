//
//  AppDelegate+YXBTheme.swift
//  YXBSwiftProject
//
//  Created by YangXiaoBin on 2020/6/18.
//  Copyright © 2020 ShengChang. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func initYXBThemeConfig() {
//        [YXBThemeManager sharedInstance].currentThemeIdentifier = YXBThemeIndetifierWhite;
        
        // 1. 先注册主题监听，在回调里将主题持久化存储，避免启动过程中主题发生变化时读取到错误的值
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleThemeDidChangeNotification), name: NSNotification.Name.QMUIThemeDidChange, object: nil)
        
        QMUIThemeManagerCenter.defaultThemeManager.themeGenerator = {(identifier) ->(NSObject?) in
            // 2. 然后设置主题的生成器 // 如果遇到该 identifier 尚未被注册，则会尝试通过这个 block 来获取对应的主题对象并添加到 QMUIThemeManager 里
            // 本来应该是reteun nil的。再swift中 不知道怎么返回nil
            //            var empty = NSObject()
            if (identifier as! String == QMUIThemeManagerNameDefault) {
                return QMUIConfigurationTemplate()
            }
            if (identifier as! String == YXBThemeIndetifierWhite) {
                return QMUIConfigurationTemplateWhite()
            }
            if (identifier as! String == YXBThemeIndetifierDark) {
                return QMUIConfigurationTemplateDark()
            }
            return nil
        }
        
        YXBThemeManager.sharedInstance().currentThemeIdentifier = YXBThemeIndetifierWhite
        
        // 3. 再针对 iOS 13 开启自动响应系统的 Dark Mode 切换
        // 如果不需要这个功能，则不需要这一段代码
        
        if #available(iOS 13.0, *) {
            // 做这个 if(currentThemeIdentifier) 的保护只是为了避免 QD 里的配置表没启动时，没人为 currentTheme/currentThemeIdentifier 赋值，导致后续的逻辑会 crash，业务项目里理论上不会有这种情况出现，所以可以省略这个 if 块
            if ((QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier) != nil) {
                
                QMUIThemeManagerCenter.defaultThemeManager.identifierForTrait = {(trait) -> (NSCopying & NSObjectProtocol) in
                    // 配置暗黑模式下 的主题
                    if trait.userInterfaceStyle == UIUserInterfaceStyle.dark {
                        return YXBThemeIndetifierDark as (NSCopying & NSObjectProtocol);
                    }
                    if (QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier!.isEqual(YXBThemeIndetifierDark)) {
                        return YXBThemeIndetifierDark as (NSCopying & NSObjectProtocol);
                    };
                    return QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier!;
                };
                QMUIThemeManagerCenter.defaultThemeManager.respondsSystemStyleAutomatically = true;
            }
        }
    }
    
    // 添加通知监听
    @objc func handleThemeDidChangeNotification(notification: NSNotification) -> Void {
        let manager : QMUIThemeManager = notification.object as! QMUIThemeManager;
        if (!(manager.name as! String == QMUIThemeManagerNameDefault)) {
            return
        }
        UserDefaults.standard.set(manager.currentThemeIdentifier, forKey: YXBSelectedThemeIdentifiert)
        
        // 刷新 全局配置表
        let theme: (YXBThemeProtocol)  = YXBThemeManager.sharedInstance().currentTheme!;
        theme.applyConfigurationTemplate();
        
        // 主题发生变化，在这里更新全局 UI 控件的 appearance
        YXBUIHelper.renderGlobalAppearances();
        
        // 更新表情 icon 的颜色
        YXBUIHelper.updateEmotionImages();
    }
    
}
