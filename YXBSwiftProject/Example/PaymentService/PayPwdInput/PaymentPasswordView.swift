//
//  PaymentPasswordView.swift
//
//  Created by Eric Wu on 2019/7/11.
//  Copyright © 2019 Migrsoft Software Inc. All rights reserved.
//

import UIKit
import SnapKit

class PaymentPasswordView: UIView {
    @IBOutlet var btnForget: UIButton!
    @IBOutlet var containerView: UIView!

    @IBOutlet var stackView: UIStackView!

    public var lblTags = [UILabel]()

    override func awakeFromNib() {
        super.awakeFromNib()
        width = UIScreen.main.bounds.width

        containerView.layer.borderWidth = 1
        
        containerView.layer.borderColor = UIColor(hexString: "#e5e5e5")?.cgColor
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 5

        let length = 6
        for idx in 0 ..< length {
            let label = UILabel()
            label.tag = idx
            label.isUserInteractionEnabled = false
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textColor = UIColor(hexString: "1E1F23")
            stackView.addArrangedSubview(label)
            lblTags.append(label)

            if idx < length {
                let line = UIView()
                line.backgroundColor = UIColor(hexString: "#e5e5e5")
                label.addSubview(line)
                line.snp.makeConstraints { make in
                    make.top.right.bottom.equalTo(0)
                    make.width.equalTo(1)
                }
            }
        }
    }
}
