//
//  LQLabelTextFieldView.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/9/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import SwifterSwift

class LQLabelTextFieldView: UIView {
    
    let bankTextField: UITextField = {
        return MyUIFactory.commonTextField(textColor: nil, font: .titleFont_14, placeHolder: "请输入银行卡号")
    }()
    
    let phoneTextField: UITextField = {
        return MyUIFactory.commonTextField(textColor: nil, font: .titleFont_14, placeHolder: "请输入手机号")
    }()
    
    let codeTextField: UITextField = {
        return MyUIFactory.commonTextField(textColor: nil, font: .titleFont_14, placeHolder: "请输入验证码")
    }()
    
    // 获取验证码按钮
    lazy var captchaBtn: YXBCountDownButton = {
        // 注意：second为关键字,相当于占位符，会在运行时替换为秒数，所以可以自定义你想要的文本，如：
        let captchaBtn = MyUIFactory.countDownButton(normal: "获取验证码", disabled: "second秒后重试")
        captchaBtn.setTitleColor(.blue, for: .normal)
        captchaBtn.addTarget(self, action: #selector(sendMessageCodeAction(_:)), for: .touchUpInside)
        return captchaBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatUI()
    }
        
    func creatUI() {
        let whiteBgView = UIView()
        whiteBgView.backgroundColor = .white
        whiteBgView.cornerRadius = 20
        addSubview(whiteBgView)
        
        let tipLabel = MyUIFactory.commonLabel(text: "添加银行卡", textColor: .titleColor, font: .titleFont_16)
        whiteBgView.addSubview(tipLabel)
        
        let tipLabel2 = MyUIFactory.commonLabel(text: "当前交易不支持信用卡，请使用储蓄卡", textColor: .subTitleColor, font: .titleFont_14)
        whiteBgView.addSubview(tipLabel2)
        
        let bankTipLabel = MyUIFactory.commonLabel(text: "银行卡", textColor: .titleColor, font: .titleFont_14)
        whiteBgView.addSubview(bankTipLabel)
        
        let phoneTipLabel = MyUIFactory.commonLabel(text: "手机号", textColor: .titleColor, font: .titleFont_14)
        whiteBgView.addSubview(phoneTipLabel)
        
        let codeTipLabel = MyUIFactory.commonLabel(text: "验证码", textColor: .titleColor, font: .titleFont_14)
        whiteBgView.addSubview(codeTipLabel)
        
        whiteBgView.addSubviews([bankTextField, phoneTextField, codeTextField, captchaBtn])
        
        whiteBgView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(230)
        }
        
        tipLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(16)
        }
        
        tipLabel2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipLabel.snp.bottom).offset(10)
        }
        
        bankTipLabel.snp.makeConstraints { make in
            make.top.equalTo(tipLabel2.snp.bottom).offset(20)
            make.left.equalTo(35)
            make.width.equalTo(80)
        }
        
        bankTextField.snp.makeConstraints { make in
            make.left.equalTo(bankTipLabel.snp.right).offset(10)
            make.centerY.equalTo(bankTipLabel)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        
        phoneTipLabel.snp.makeConstraints { make in
            make.top.equalTo(bankTipLabel.snp.bottom).offset(25)
            make.left.equalTo(35)
            make.width.equalTo(80)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.left.equalTo(phoneTipLabel.snp.right).offset(10)
            make.centerY.equalTo(phoneTipLabel)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        
        codeTipLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTipLabel.snp.bottom).offset(25)
            make.left.equalTo(35)
            make.width.equalTo(80)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.left.equalTo(codeTipLabel.snp.right).offset(10)
            make.centerY.equalTo(codeTipLabel)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        
        captchaBtn.snp.makeConstraints { make in
            make.right.equalTo(codeTextField.snp.right).offset(-10)
            make.centerY.equalTo(codeTextField)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
    }
    
    // 点击事件
    @objc func sendMessageCodeAction(_ sender: UIButton) {
        // 一般做网络请求之后， 再设置
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.captchaBtn.maxSecond = 30
            self.captchaBtn.countdown = true
        }
    }
    
    
    deinit {
        debugPrint(self.className() + " deinit 🍺")
        // 停止定时器
        self.captchaBtn.countdown = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
