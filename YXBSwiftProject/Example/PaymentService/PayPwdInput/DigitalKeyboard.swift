//
//  DigitalKeyboard.swift
//  GCCX
//
//  Created by Eric on 2019/8/29.
//  Copyright © 2019 Migrsoft Software Inc. All rights reserved.
//

import UIKit
import Rswift

class DigitalKeyboard: UIInputView {
    let keyboardHeight: CGFloat = 220

    /// 是否随机
    private var randomFlag: Bool = false
    private var buttions: [UIButton] = []
    private weak var textField: UITextField?

    private let contentView = UIView()

    public convenience init(_ random: Bool = false, textField: UITextField) {
        self.init(frame: CGRect.zero, inputViewStyle: .keyboard)
        randomFlag = random
        self.textField = textField
        setUpUI()
    }

    private override init(frame _: CGRect, inputViewStyle: UIInputView.Style) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: keyboardHeight + QMUIHelper.safeAreaInsetsForDeviceWithNotch().bottom), inputViewStyle: inputViewStyle)
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        backgroundColor = UIColor.qmui_color(withHexString: "ECECEC")
        addSubview(contentView)
        contentView.frame = bounds
        customSubview()
    }

    private func customSubview() {
        var titles = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        if randomFlag {
            titles.shuffle()
        }
        let lineW: CGFloat = 0.5
        let buttonH: CGFloat = 55
        let buttonW = UIScreen.main.bounds.width / 3

        var index: Int = 0
        let count = 12
        for idx in 0 ..< count {
            if idx == 9 {
                continue
            }
            let btn = UIButton(type: .custom)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            btn.setTitleColor(UIColor.black, for: .normal)

            buttions.append(btn)
            contentView.addSubview(btn)
            if idx == count - 1 {
                btn.addTarget(self, action: #selector(btnDeleteOnClick(_:)), for: .touchUpInside)
                btn.setImage(UIImage(named: "keyboard_del_normal"), for: .normal)
                
                btn.setImage(UIImage(named: "keyboard_del_press"), for: .highlighted)

            } else {
                btn.backgroundColor = UIColor.white
                btn.addTarget(self, action: #selector(btnTextOnClick(_:)), for: .touchUpInside)
                btn.setTitle(titles[index], for: .normal)
                index += 1
            }
            let colum = idx % 3
            let row = idx / 3
            btn.frame = CGRect(x: CGFloat(colum) * buttonW, y: CGFloat(row) * buttonH, width: buttonW, height: buttonH)
        }

        for idx in 0 ... 3 {
            let horizontallyLine = UIView()
            horizontallyLine.backgroundColor = UIColor.qmui_color(withHexString: "E5E5E5")
            horizontallyLine.frame = CGRect(x: 0, y: buttonH * CGFloat(idx), width: UIScreen.main.bounds.width, height: lineW)
            contentView.addSubview(horizontallyLine)
        }
        for idx in 1 ... 2 {
            let verticallyLine = UIView()
            verticallyLine.backgroundColor = UIColor.qmui_color(withHexString: "E5E5E5")
            verticallyLine.frame = CGRect(x: buttonW * CGFloat(idx), y: 0, width: lineW, height: keyboardHeight)
            contentView.addSubview(verticallyLine)
        }
    }

    // MARK: - buttonOnClick

    @objc private func btnDeleteOnClick(_ btn: UIButton) {
        textField?.deleteBackward()
    }

    @objc private func btnTextOnClick(_ btn: UIButton) {
        guard let text = btn.currentTitle else { return }
        textField?.insertText(text)
    }
}
