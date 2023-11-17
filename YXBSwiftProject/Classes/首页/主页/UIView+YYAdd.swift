//
//  UIView+YYAdd.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/17.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Foundation

extension UIView {
    func yxb_snapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
    }
}
