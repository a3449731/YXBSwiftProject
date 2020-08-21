//
//  PaymentkeyboardView.swift
//
//  Created by Eric Wu on 2019/7/11.
//  Copyright © 2019 Migrsoft Software Inc. All rights reserved.
//

import BiometricAuthentication
//import IQKeyboardManagerSwift
import UIKit
import YYCategories
import IQKeyboardManager

public typealias CRVoidBlock = () -> Void
public typealias CRCompletionTask = CRVoidBlock
public let kEmptyString = ""
public let kSeparatorSolidDot = "●"


class PaymentKeyboardView: UIView {
    typealias PayBlock = (_ inputType: AuthType, _ payCompletion: @escaping (_ paySucceed: Bool) -> Void) -> Void
    
    enum AuthType {
        case input(password: String)
        case bio
    }
    
    var payBlock: PayBlock!
    var didFinish: (()->Void)? = nil
    var didCancel: (()->Void)? = nil
    
    /// 找回密码
    var showForgetBtn = true { 
        didSet { passwordView.btnForget.isHidden = !showForgetBtn }
    }
    var forgetPasswordOnClick: CRCompletionTask?

    /// 标题
    var title: String?

    /// 价格
    var price: String?

    /// 是否需要确认订单
    var needSure: Bool = false

    // 是否开启了指纹支付
    var touchPayEnabled: Bool = false
    
    /// 确认信息
    var items = [TableViewCellItem]()

    /// 点击关闭按钮记录状态
    private var canClose = true

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet var btnClose: UIButton!
    @IBOutlet var containerView: UIView!
    @IBOutlet var containerBottom: NSLayoutConstraint!

    @IBOutlet var containerHeight: NSLayoutConstraint!

    private let kPasswordLength = 6
    private lazy var textFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.autocorrectionType = .no
        textFiled.autocapitalizationType = .none
        textFiled.keyboardType = .numberPad
        return textFiled
    }()

    private lazy var passwordView: PaymentPasswordView = UIView.loadFromNib(named: "PaymentPasswordView", bundle: .main) as! PaymentPasswordView
    private lazy var orderView: PaymentSureInfoView = UIView.loadFromNib(named: "PaymentSureInfoView", bundle: .main) as! PaymentSureInfoView
    private lazy var shadowView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return shadowView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        textFiled.shouldResignOnTouchOutsideMode = .disabled
        frame = CRScreenBounds()
//        if CRIsIphoneX() {
//            containerHeight.constant = 540
//        } else {
//        }
        containerHeight.constant = 465
        containerBottom.constant = containerHeight.constant

        layoutIfNeeded()
        setUpUI()
    }

    func setUpUI() {
        insertSubview(shadowView, at: 0)
        shadowView.addTapRecognizer(target: self, action: #selector(headerTapOnMaskView(gesture:)))
        shadowView.frame = bounds

        addSubview(textFiled)

        let keyboard = DigitalKeyboard(true, textField: textFiled)
        textFiled.inputView = keyboard

        textFiled.width = width
        textFiled.bottom = height
        textFiled.isHidden = true
        textFiled.addTarget(self, action: #selector(textFieldOnEditingChanged(textField:)), for: .editingChanged)

        textFiled.delegate = self

        contentView.addSubview(passwordView)
        contentView.addSubview(orderView)

        let orderY: CGFloat = 0
        orderView.frame = CGRect(x: 0, y: orderY, width: width, height: contentView.height - orderY)

        orderView.btnSure.addTarget(self, action: #selector(btnSureOrderOnClick(_:)), for: .touchUpInside)
        passwordView.width = width
        orderView.width = width

        btnClose.addTarget(self, action: #selector(btnCloseOnClick(_:)), for: .touchUpInside)
        passwordView.btnForget.addTarget(self, action: #selector(btnForgetOnClick(_:)), for: .touchUpInside)
    }

    func resetToDefault() {
        textFiled.text = kEmptyString
        refreshPassword()
    }

    // MARK: - buttonOnClick

    @objc func btnForgetOnClick(_ btn: UIButton) {
        forgetPasswordOnClick?()
    }

    @objc func btnCloseOnClick(_ btn: UIButton) {
        if canClose {
            dismiss()
            didCancel?()
        } else {
            toggleOrderInfo(backOrder: true)
        }
    }

    @objc func btnSureOrderOnClick(_ btn: UIButton) {
        btn.lockUserInteraction(2)
        if touchPayEnabled {
            startCheckTouchID()
        } else {
            toggleOrderInfo(backOrder: false)
        }
    }

    // MARK: - gesture

    @objc func headerTapOnMaskView(gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            dismiss()
            didCancel?()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let view = touches.first?.view, view == passwordView.stackView {
            if !textFiled.isFirstResponder {
                textFiled.becomeFirstResponder()
            }
        }
    }

    // MARK: - custom metchod

    func refreshPassword() {
        if let toBeString = textFiled.text {
            passwordView.lblTags.enumerated().forEach { arg0 in
                let (offset, element) = arg0
                if offset < toBeString.count {
//                    let range = toBeString.index(toBeString.startIndex, offsetBy: offset)
//                    element.text = String(toBeString[range])
                    element.text = kSeparatorSolidDot
                } else {
                    element.text = kEmptyString
                }
            }

            if toBeString.count == kPasswordLength {
                lockUserInteraction()
                
                payBlock(.input(password: toBeString), { [weak self] isValid in
                    if isValid {
                        self?.endEditing(true)
                        self?.dismiss()
                        self?.didFinish?()
                    } else {
                        self?.textFiled.text = kEmptyString
                        self?.refreshPassword()
                    }
                })
            }
        }
    }

    func show(_ view: UIView = CRMainWindow()) {
        view.addSubview(self)
        containerBottom.constant = 0
        if needSure {
            orderView.left = 0
            passwordView.left = width
            setUpOrderInfo()
        } else {
            textFiled.becomeFirstResponder()
            orderView.left = width
            passwordView.left = 0
        }
        shadowView.alpha = 0.001
        UIView.animate(withDuration: 0.25) {
            self.shadowView.alpha = 1
            self.layoutIfNeeded()
        }
    }

    func dismiss(_ complete: CRCompletionTask? = nil) {
        guard containerBottom.constant == 0 else {
            return
        }
        textFiled.resignFirstResponder()
        containerBottom.constant = containerHeight.constant
        UIView.animate(withDuration: 0.25, animations: {
            self.shadowView.alpha = 0.001
            self.layoutIfNeeded()
        }) { _ in
            self.removeFromSuperview()
            complete?()
        }
    }

    /// 设置订单信息
    func setUpOrderInfo() {
        lblTitle.text = title ?? "确认支付"
        title = lblTitle.text
        orderView.lblPrice.text = price

        var line = UIView()
        orderView.orderInfoView.addSubview(line)
        line.backgroundColor = UIColor(hexString: "#e5e5e5")
        line.size = CGSize(width: width, height: 1)
        items.enumerated().forEach { arg0 in
            let (_, element) = arg0
            let lastView = orderView.orderInfoView.subviews.last!
            let lblTitle = UILabel()
            lblTitle.text = element.title
            lblTitle.font = UIFont.systemFont(ofSize: 14)
            lblTitle.textColor = UIColor(hexString: "#8e9198")
            lblTitle.sizeToFit()
            lblTitle.left = 16
            lblTitle.top = lastView.bottom
            lblTitle.height = 50
            orderView.orderInfoView.addSubview(lblTitle)

            let lblDetail = UILabel()
            lblDetail.text = element.detailTitle
            lblDetail.textAlignment = .right
            lblDetail.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            lblDetail.textColor = UIColor(hexString: "#1e1f23")
            lblDetail.sizeToFit()
            lblDetail.right = width - 16
            lblDetail.top = lblTitle.top
            lblDetail.height = 50
            orderView.orderInfoView.addSubview(lblDetail)

            line = UIView()
            orderView.orderInfoView.addSubview(line)
            line.backgroundColor = UIColor(hexString: "#e5e5e5")
            line.frame = CGRect(x: 0, y: 0, width: width, height: 1)
            line.bottom = lblTitle.bottom
        }
    }

    func toggleOrderInfo(backOrder: Bool) {
        if backOrder {
            canClose = true
            textFiled.resignFirstResponder()
            btnClose.setImage(UIImage(named: "mf_ic_close_black"), for: .normal)
            lblTitle.text = title

        } else {
            canClose = false
            textFiled.becomeFirstResponder()
            btnClose.setImage(UIImage(named: "common_arrow_back"), for: .normal)
            lblTitle.text = "输入交易密码"
        }
        UIView.animate(withDuration: 0.25) {
            if backOrder {
                self.orderView.left = 0
                self.passwordView.left = self.width
            } else {
                self.orderView.left = -self.width
                self.passwordView.left = 0
            }
        }
    }

    // MARK: - touch

    func startCheckTouchID() {
        let isTouchId = BioMetricAuthenticator.shared.touchIDAvailable()
        let msg = isTouchId ? "通过Home键验证已有手机指纹" : "面容 ID 短时间内失败多次，需要验证手机密码"
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: msg, fallbackTitle: "输入密码", cancelTitle: "取消") { result in
            let isTouchId = BioMetricAuthenticator.shared.touchIDAvailable()
            switch result {
            case .success:
                self.payBlock(.bio, { [weak self] isValid in
                    if isValid {
                        self?.endEditing(true)
                        self?.dismiss()
                        self?.didFinish?()
                    } else {
                        // 校验失败，由外部处理
                    }
                })
//                if let paymentPwd = UserManager.payPwdForKeychain() {
//                    PaymentManager.default.checkPaymentPwd(paymentPwd) { [weak self] isVaild in
//                        if isVaild {
//                            self?.inputSucceed?(paymentPwd)
//                        } else {
//                        }
//                    }
//                }
            case let .failure(error):
                let msg = isTouchId ? "\"指纹Touch ID\"" : "\"Face ID\""
                switch error {
                case .failed:
                    
                    Toast.showInfo("验证失败", in: self)
                case .fallback: // 用户点击输入密码按钮
                    if self.needSure {
                        self.toggleOrderInfo(backOrder: false)
                    } else {
                        self.show()
                    }
                case .canceledByUser: // 用户取消
                    break
//                    MR.showToast(message: "用户取消")
                case .biometryNotEnrolled: // 认证无法启动，因为没有登记身份
                    Toast.showInfo("未设置(\(msg))，请先在手机系统中添加指纹", in: self)
                case .biometryLockedout: // 认证是不成功的，因为有太多的失败的尝试和生物统计学生物现在锁定
                    Toast.showInfo("您的(\(msg))，被锁定，请锁定一次屏幕后再尝试开启\(msg)解锁", in: self)
                case .biometryNotAvailable:
                    Toast.showInfo("应用无\(msg)使用权限，请在iPhone的“设置-面容ID与密码”选项中开启权限", in: self)
                default:
                    Toast.showInfo(error.localizedDescription, in: self)
                    //                case .fallback: // 用户点击输入密码按钮
                    //                case .canceledBySystem: // 系统取消
                    //                case .passcodeNotSet: // 用户没有设置解锁密码
                    //                case .biometryNotAvailable: // 认证无法启动，因为数据不可用的设备
                    //                case .other:
                    //                    break
                }
            }
        }
    }

    deinit {
        print("\n\(self)\n")
    }
}

extension PaymentKeyboardView: UITextFieldDelegate {
    @objc func textFieldOnEditingChanged(textField: UITextField) {
        let limit = kPasswordLength
        if var toBeString = textFiled.text {
            if toBeString.count > limit {
                let index = toBeString.index(toBeString.startIndex, offsetBy: limit)
                toBeString = String(toBeString[..<index])
                textField.text = toBeString
            }
        }
        refreshPassword()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let toBeString = textFiled.text {
            if toBeString.count == kPasswordLength {
                if range.length == 0 {
                    return false
                }
            }
        }
        return true
    }
}
