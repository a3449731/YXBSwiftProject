//
//  AppDelegate.swift
//  YXBSwiftProject
//
//  Created by YangXiaoBin on 2020/6/18.
//  Copyright © 2020 ShengChang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DebugToolSwiftBridge.setup()
        
        self.allApplicationCofing()
        
        self.setupMainViewController()
        
//        checkAPPVersion()
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
//        checkAPPVersion()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // 支付宝回调
        self.aliPayResultConsume(app, open: url, options: options)
        
        return true
    }
    
    func allApplicationCofing() -> Void {
        // 网络配置
        YXBNetConfiger.configer()
        
        //语言配置
        NTVLocalized.sharedInstance()?.initLanguage();
        
        // 人脸识别
        //        CheckSDK.initSDK(withAPPkey: "3BHicOLN", appid: "w8XfbjZK")
        
        // 透明遮罩 不允许点击
        SVProgressHUD.setDefaultMaskType(.clear)
        
        // 主题配置
        self.initYXBThemeConfig()
        
        // 阿里云刷脸初始化
//        self.aliYunInit()
        
        // 神蓄广告配置
//        OSETManager.configure(SZAdAppKey)
        
        // 检测版本
//        checkAPPVersion();
        
    }
    
    func setupMainViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
//        let isLogin: Bool = UserManager.shared().personalInfo.isLogin
//        if isLogin {
            let tabBar = TabBarViewController.init()
            self.window?.rootViewController = tabBar;
            self.window?.makeKeyAndVisible()
//        } else {
//            let loginVc = LoginViewController.init()
//            let nav = YXBNavigationController.init(rootViewController: loginVc)
//            self.window?.rootViewController = nav;
//            self.window?.makeKeyAndVisible()
//        }
    }
}
