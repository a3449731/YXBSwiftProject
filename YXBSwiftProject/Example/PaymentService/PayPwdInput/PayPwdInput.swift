//
//  PayPwdInput.swift
//
//  Created by Eric Wu on 2019/7/11.
//  Copyright © 2019 Migrsoft Software Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PayPwdInput : NSObject {
    typealias PayBlock = (_ pwd: String, _ payBlock: @escaping (_ paySucceed: Bool)->Void) -> Void
    
    static var paymentView: PaymentKeyboardView? = nil
    static var paymentDidFinish: ((Bool) -> Void)?
    
//    @objc class func showPay(title: String? = nil, needSure: Bool = false, price: String? = nil, items: [TableViewCellItem] = []) {
//        
//    }
    
    // 此方法隐藏了取消输入密码这个行为，⚠️使用此方法在支付完成时需要调用 finishPayment 来隐藏密码输入
    static func handlePay(title: String? = nil, needSure: Bool = false, price: String? = nil, items: [TableViewCellItem] = []) -> Driver<String> {
        return Observable<String>.create { (observer) -> Disposable in
            self.handlePay(title: title, needSure: needSure, price: price, items: items, payBlock: { (pwd, payCompletion) in
                self.paymentDidFinish = payCompletion
                observer.onNext(pwd)
            }, onCancel: { 
                observer.onCompleted()
            }, onFinish: { 
                observer.onCompleted()
            })
            return Disposables.create {
                observer.onCompleted()
            }
        }.asDriver(onErrorJustReturn: "")
    }
    // 使用上面的方法时需要调用
    static func finishPayment(_ success: Bool) {
        paymentDidFinish?(success)
    }
    
    // needSure 是否需要确认订单
    // price 订单总价
    // items 支付抵扣明细
    // payBlock 密码输入完成，交给业务去调用支付接口，支付完成后需要调用 completion
    @objc static func handlePay(title: String? = nil, needSure: Bool = false, price: String? = nil, items: [TableViewCellItem] = [], payBlock: @escaping PayBlock, onCancel: CRVoidBlock? = nil, onFinish: CRVoidBlock? = nil) {
        if paymentView != nil {
            paymentView?.dismiss()
            paymentView = nil
        }
        setupPaymentView(with: payBlock, onCancel: onCancel, onFinish: onFinish)
        if needSure {
            paymentView?.items = items
        }
        paymentView?.needSure = needSure
        paymentView?.price = price
        paymentView?.title = title
        
        if needSure {
            paymentView?.show()
        } else {
            /*
            if let _ = UserManager.shared.pwdPay { // 开启指纹 & 面容支付
                paymentView?.startCheckTouchID()
            } else {
                paymentView?.show()
            }
            */
            
            paymentView?.show()
        }
        
//        loadUserIsSetPaymentPwd { [weak self] hasPaymentPwd in
//            if hasPaymentPwd {
//                if needSure {
//                    self?.keyboardView?.show()
//                } else {
//                    if UserManager.touchPayAvailable() { // 开启指纹 & 面容支付
//                        self?.keyboardView?.startCheckTouchID()
//                    } else {
//                        self?.keyboardView?.show()
//                    }
//                }
//            } else {
//                self?.keyboardView?.dismiss()
//                self?.finalize()
//                CRPresentAlert(title: nil, msg: "请先设置支付密码", handler: { action in
//                    if "确定" == action.title {
//                        let ctrl = AccountSecurityViewController()
//                        CRTopViewController()?.navigationController?.pushViewController(ctrl, animated: true)
//                    }
//                }, canel: "取消", action: "确定")
//            }
//        }
    }

    private static func setupPaymentView(with payBlock: @escaping PayBlock, onCancel: CRVoidBlock?, onFinish: CRVoidBlock?) {
        
        paymentView = (UIView.loadFromNib(named: "PaymentKeyboardView", bundle: .main) as! PaymentKeyboardView)
        paymentView?.width = UIScreen.main.bounds.width
        paymentView?.showForgetBtn = false
        
        paymentView?.payBlock = { r, block in
            let pwd: String
            switch r {
            case let .input(password):  pwd = password
                // 忽略了指纹和刷脸， 有需求再来使用
//            case .bio:                  pwd = UserManager.shared.pwdPay ?? ""
            case .bio:                  pwd = ""
            }
            if pwd.count > 0 {
                payBlock(pwd, { success in
                    block(success)
                    if success {
                        paymentView?.dismiss()
                    } else {
                    }
                })
            } else {
                block(false)
            }
        }
        
//        paymentView?.forgetPasswordOnClick = {
//            paymentView?.dismiss({
//                self.finalize()
//                let ctrl = AccountSecurityViewController()
//                Router.show(ctrl, wrap: BaseNavigationController.self)
//            })
//        }
        
        paymentView?.didFinish = {
            self.finalize()
            onFinish?()
        }
        
        paymentView?.didCancel = {
            self.finalize()
            onCancel?()
        }
    }

    override static func finalize() {
        paymentDidFinish = nil
        paymentView = nil
    }

    // MARK: - network

    /// 获取用户是否设置密码
    ///
    /// - Parameter completion: 是否设置密码
//    func loadUserIsSetPaymentPwd(_ completion: @escaping (_ hasPaymentPwd: Bool) -> Void) {
//        let api = kURLIsSetPaymentPwd
//        NetworkManager.request(api: api) { [weak self] succeed, response in
//            if succeed {
//                var data: Any = []
//                if PackageManager.checkResponseSucceed(json: response, data: &data) {
//                    let hasPaymentPwd = data as! Bool
//                    completion(hasPaymentPwd)
//                } else {
//                    let json = JSON(response as Any)
//                    showToast(message: json[JSON_MSG_KEY].stringValue)
//                }
//            } else {
//                CRPresentAlert(title: nil, msg: kNetworkFailureMessage, handler: { [weak self] action in
//                    if "重试" == action.title {
//                        self?.loadUserIsSetPaymentPwd(completion)
//                    }
//                }, canel: "取消", action: "重试")
//            }
//        }
//    }

    /// 效验支付密码是否正确
    ///
    /// - Parameter completion: <#completion description#>
//    func checkPaymentPwd(_ paymentPwd: String, _ completion: @escaping (_ isValid: Bool) -> Void) {
//        let api = kURLCheckPaymentIsValid
//        NetworkManager.request(api: api, parameters: ["paymentPwd": paymentPwd]) { [weak self] succeed, response in
//            if succeed {
//                var data: Any = []
//                if PackageManager.checkResponseSucceed(json: response, data: &data) {
//                    completion(true)
//                } else {
//                    let json = JSON(response as Any)
//                    self?.keyboardView?.makeToast(json[JSON_MSG_KEY].stringValue, position: ToastPosition.center)
//                    completion(false)
//                }
//            } else {
//                CRPresentAlert(title: nil, msg: kNetworkFailureMessage, handler: { [weak self] action in
//                    if "重试" == action.title {
//                        self?.checkPaymentPwd(paymentPwd, completion)
//                    }
//                }, canel: "取消", action: "重试")
//            }
//        }
//    }
}
