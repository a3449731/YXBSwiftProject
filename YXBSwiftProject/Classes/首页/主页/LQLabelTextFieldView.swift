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
    let titleLabel: UILabel = {
        return MyUIFactory.commonLabel(text: nil, textColor: .titleColor)
    }()
    
    let textField: UITextField = {
        return MyUIFactory.commonTextField(textColor: nil, placeHolder: "你好")  
    }()
    
    // 按钮
    lazy var captchaBtn: YXBCountDownButton = {
        // 注意：second为关键字,相当于占位符，会在运行时替换为秒数，所以可以自定义你想要的文本，如：
        let captchaBtn = MyUIFactory.countDownButton(normal: "获取验证码", disabled: "second秒后重试")
        captchaBtn.addTarget(self, action: #selector(sendMessageCodeAction(_:)), for: .touchUpInside)
        return captchaBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatUI()
    }
        
    func creatUI() {
        
    }
    
    // 点击事件
    @objc func sendMessageCodeAction(_ sender: UIButton) {
        // 一般做网络请求之后， 再设置
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.captchaBtn.maxSecond = 30
            self.captchaBtn.countdown = true
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
