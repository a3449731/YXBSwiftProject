//
//  GSCaptchaButton.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/9/28.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit

/// 一个倒计时按钮，常用语短信验证码倒计时
/**
 // 使用示例
 lazy var captchaBtn: YXBCountDownButton = {
     let captchaBtn = YXBCountDownButton(type: .custom)
     // 注意：second为关键字,相当于占位符，会在运行时替换为秒数，所以可以自定义你想要的文本，如：
     captchaBtn.setTitle("获取验证码", for: .normal)
     captchaBtn.setTitle("second秒后重试", for: .disabled)
     captchaBtn.addTarget(self, action: #selector(sendMessageCodeAction(_:)), for: .touchUpInside)
     return captchaBtn
 }()
 
 // 点击事件
 @objc func sendMessageCodeAction(_ sender: UIButton) {
     // 一般做网络请求之后， 再设置
     DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
         self.captchaBtn.maxSecond = 30
         self.captchaBtn.countdown = true
     }
 }
***/
///
public class YXBCountDownButton: UIButton {

    // MARK: Properties
    
    public var maxSecond = 60
    public var countdown = false {
        didSet {
            if oldValue != countdown {
                countdown ? startCountdown() : stopCountdown()
            }
        }
    }
    
    private var second = 0
    private var timer: Timer?
    
    private var timeLabel = UILabel()
    private var normalText: String!
    private var normalTextColor: UIColor!
    private var disabledText: String!
    private var disabledTextColor: UIColor!
    
    // MARK: Life Cycle
    
    deinit {
        countdown = false
    }
    
    // MARK: Setups
    
    private func setupLabel() {
        guard timeLabel.superview == nil else { return }
        
        normalText = title(for: .normal) ?? ""
        disabledText = title(for: .disabled) ?? ""
        normalTextColor = titleColor(for: .normal) ?? .white
        disabledTextColor = titleColor(for: .disabled) ?? .white
        setTitle("", for: .normal)
        setTitle("", for: .disabled)
        timeLabel.frame = bounds
        timeLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        timeLabel.textAlignment = .center
        timeLabel.font = titleLabel?.font
        timeLabel.textColor = normalTextColor
        timeLabel.text = normalText
        addSubview(timeLabel)
    }
    
    // MARK: Private
    
    private func startCountdown() {
        setupLabel()
        second = maxSecond
        updateDisabled()
        
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    private func stopCountdown() {
        timer?.invalidate()
        timer = nil
        updateNormal()
    }
    
    private func updateNormal() {
        isEnabled = true
        timeLabel.textColor = normalTextColor
        timeLabel.text = normalText
    }
    
    private func updateDisabled() {
        isEnabled = false
        timeLabel.textColor = disabledTextColor
        timeLabel.text = disabledText.replacingOccurrences(of: "second", with: "\(second)")
    }
    
    @objc private func updateCountdown() {
        second -= 1
        if second <= 0 {
            countdown = false
        } else {
            updateDisabled()
        }
    }

}
