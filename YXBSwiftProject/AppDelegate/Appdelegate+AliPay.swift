//
//  Appdelegate+AliPay.swift
//  YXBSwiftProject
//
//  Created by YangXiaoBin on 2020/7/22.
//  Copyright © 2020 ShengChang. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func aliPayResultConsume(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) {
        
        if url.host == "safepay" {
            
            // 支付跳转支付宝钱包进行支付，处理支付结果
            AlipaySDK.defaultService()?.processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
                self.aliPayResule(resultDic! as NSDictionary)
            })
            
            /**
             *  处理支付宝app授权后跳回商户app携带的授权结果Url
             *
             *  @param resultUrl        支付宝app返回的授权结果url
             *  @param completionBlock  授权结果回调,用于处理跳转支付宝授权过程中商户APP被系统终止的情况
             */
            /*
            AlipaySDK.defaultService()?.processAuth_V2Result(url, standbyCallback: { (resultDic) in
                self.aliLoginResule(resultDic! as NSDictionary)
            })
            */
            
        }
        
        // 进行了支付宝刷脸认证, 需要配置URL schme
        if url.scheme == "alipayVertify147147" {
            NotificationCenter.default.post(name: NSNotification.Name.init("YXBAlipayCertifyResult"), object: nil)
        }
    }
    
    func aliPayResule(_ resultDic: NSDictionary) -> Void {
        let status = resultDic.value(forKey: "resultStatus")
        let resultStatus = NSInteger(status as! String)
        switch resultStatus {
        case 9000: NotificationCenter.default.post(name: NSNotification.Name.YXBPaymentSuccess, object: nil)
            case 4000: NotificationCenter.default.post(name: NSNotification.Name.YXBPaymentFail, object: nil)
            case 6001: NotificationCenter.default.post(name: NSNotification.Name.YXBPaymentCancel, object: nil)
            default: NotificationCenter.default.post(name: NSNotification.Name.YXBPaymentFail, object: nil)
        }
    }
    
    
    // 实际上在这里没有做什么处理，是对APP意外终止情况的补充
    func aliLoginResule(_ resultDic: NSDictionary) -> Void {
        // 解析 auth code
        let result: NSString = resultDic.value(forKey: "result") as! NSString
        var authCode: NSString
        if result.length > 0 {
            let resultArr = result.components(separatedBy: "&")
            for subResult in resultArr {
                if subResult.count > 10 && subResult.hasPrefix("auth_code=") {
                    authCode = (subResult as NSString).substring(from: 10) as NSString
                }
            }
        }
    }
    
}
    
