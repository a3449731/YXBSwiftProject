//
//  PaymentService.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2020/4/20.
//  Copyright © 2020 -. All rights reserved.
//

import Foundation
import YYCategories
import RxSwift

final class PaymentService: NSObject {
    
    @objc static let `default` = PaymentService()

    @objc func setup() {
//        NotificationCenter.default.addObserver(IpaynowPluginApi.self, selector: #selector(IpaynowPluginApi.didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
//    func pay(for orderNum: String, with channel: PayChannel) {
//        if channel == .yue {
//            payViaYue(for: orderNum)
//        } else if channel == .alipay {
//            payAliPay(for: orderNum)
//        } else {
//            payOrder(with: orderNum, via: channel)
//        }
//    }
    
    func payViaYue(for orderNum: String) {
//        PayPwdInput.handlePay(title: "请输入支付密码", payBlock: { [weak self] (pwd, completion) in
//            self?.payOrder(with: orderNum, via: .yue, pwd: pwd, completion: completion)
//        }, onCancel: {
//            NotificationCenter.default.post(name: PayViewController.Notifications.didCancel, object: nil)
//        }) {
//            NotificationCenter.default.post(name: PayViewController.Notifications.didSuccess, object: nil)
//        }
    }
    
//    func payOrder(with orderNum: String, via channel: PayChannel, pwd: String? = nil, completion: ((Bool)->Void)? = nil) {
//        let api = OrderAPI.payOrder(orderNum: orderNum, password: pwd, type: channel)
//        Network.request(api)
//            .subscribe(onSuccess: { (data) in
//                if channel == .yue {
//
//                }
//                else if let pairs = data?.array {
//                    self.payByLocalSign(pairs: pairs)
//                }
//                completion?(true)
//
//            }, onError: { (error) in
//
//                NotificationCenter.default.post(name: PayViewController.Notifications.didFail, object: nil)
//                completion?(false)
//            })
//            .disposed(by: self.disposeBag)
//    }
    
//    func payByLocalSign(pairs: [JSON]) {
//        var dict = pairs.reduce(into: [String:String]()) { (r, j) in
//            if let key = j["key"].string, let value = j["value"].string, value.isEmpty == false
//            {
//                r[key] = value //.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            }
//        }
//        dict.removeValue(forKey: "outputType")
//        dict.removeValue(forKey: "url")
//        dict.removeValue(forKey: "consumerCreateIp")
//
////        #if DEBUG
////        dict["deviceType"] = "01"
////        #endif
//        let sortedKeys = dict.keys.sorted(by: <)
//        var presignStr = sortedKeys.reduce("") { (r, k) -> String in
//            "\(r)\(k)=\(dict[k]!)&"
//        }
//        if false ==  presignStr.isEmpty {
//            presignStr.removeLast()
//        }
//
////        let keymd5 = IPNDESUtil.md5Encrypt(kIPayNowAppKey) ?? ""
////        let sign = IPNDESUtil.md5Encrypt(presignStr + "&" + keymd5) ?? ""
////        let payData = presignStr + "&mhtSignature=\(sign)&mhtSignType=MD5"
//
//        // 签名后替换 mhtReserved
//        if let v = dict["mhtReserved"], false == v.isEmpty,
//            let ve = v.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
//            presignStr = presignStr.replacingOccurrences(of: v, with: ve)
//        }
//
//        let payData = presignStr
//
//        print("IPayNow Pay: \(payData)")
//
//        IpaynowPluginApi.pay(payData, andScheme: appScheme, viewController: UIViewController.topMost, delegate: self)
//    }
//
    /*
    func iPaynowPluginResult(_ result: IPNPayResult, errorCode: String!, errorInfo: String!) {
//        #if DEBUG
        switch result {
        case .cancel:
            Toast.showInfo("支付取消")
            NotificationCenter.default.post(name: PayViewController.Notifications.didCancel, object: nil)
        case .fail:
            let msg = "支付失败, code: \(String(describing: errorCode)), info: \(String(describing: errorInfo))"
            print(msg)
            Toast.showInfo(msg)
            NotificationCenter.default.post(name: PayViewController.Notifications.didFail, object: nil)
        case .success:
            Toast.showInfo("支付成功")
            NotificationCenter.default.post(name: PayViewController.Notifications.didSuccess, object: nil)
        case .unknown:
            let msg = "支付未知状态, code: \(String(describing: errorCode)), info: \(String(describing: errorInfo))"
            Toast.showInfo(msg)
            NotificationCenter.default.post(name: PayViewController.Notifications.didFail, object: nil)
        @unknown default:
            print("需要处理新增状态 \(result)")
        }
//        #else
//        switch result {
//        case .cancel:
//            CRNotificationCenter.post(name: PayViewController.Notifications.didCancel, object: nil)
//        case .fail:
//            Toast.showInfo("支付失败")
//            CRNotificationCenter.post(name: PayViewController.Notifications.didFail, object: nil)
//        case .success:
//            Toast.showInfo("支付成功")
//            CRNotificationCenter.post(name: PayViewController.Notifications.didSuccess, object: nil)
//        case .unknown:
//            Toast.showInfo("支付失败")
//            CRNotificationCenter.post(name: PayViewController.Notifications.didFail, object: nil)
//        @unknown default:
//            print("需要处理新增状态 \(result)")
//        }
//        #endif
    }
    */
    
    @objc func payAliPay(for orderNum: String) {
        // NOTE: 调用支付结果开始支付
        AlipaySDK.defaultService()?.payOrder(orderNum, fromScheme: "jyalipay123321121", callback: { (resultDic) in
            self.aliPayResule(resultDic! as NSDictionary)
        })
    }
    
    @objc func aliPayResule(_ resultDic: NSDictionary) -> Void {
        let status = resultDic.value(forKey: "resultStatus")
        let resultStatus = NSInteger(status as! String)
        switch resultStatus {
            case 9000: NotificationCenter.default.post(name: NSNotification.Name.PaySuccess, object: nil)
            case 4000: NotificationCenter.default.post(name: NSNotification.Name.PayFail, object: nil)
            case 6001: NotificationCenter.default.post(name: NSNotification.Name.PayCancel, object: nil)
            default: NotificationCenter.default.post(name: NSNotification.Name.PayFail, object: nil)
        }
    }
}
