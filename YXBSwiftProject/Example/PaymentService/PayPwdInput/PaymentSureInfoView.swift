//
//  PaymentSureInfoView.swift
//
//  Created by Eric Wu on 2019/7/14.
//  Copyright © 2019 Migrsoft Software Inc. All rights reserved.
//

import UIKit

class PaymentSureInfoView: UIView {
    @IBOutlet var lblPrice: UILabel!

    @IBOutlet var orderInfoView: UIView!
    @IBOutlet var btnSure: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        width = UIScreen.main.bounds.width
        btnSure.layer.cornerRadius = 5
        btnSure.layer.masksToBounds = true
    }
}
