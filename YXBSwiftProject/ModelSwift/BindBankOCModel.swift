//
//  BindBankSwiftModel.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/9.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Foundation

// 使用MJExtension解析，这是备用方案，这样可以给暴露OC使用。只有当你的模型需要再OC中使用时候才考虑用MJExtension
@objc(BindBankSwiftModel)
@objcMembers
class BindBankOCModel: NSObject {
    var bankCardNo: String?
    var mobile: String?
    var bankName: String?
    var id: String?
    
    // 转换为模型
    static func jsonToModel(dic: Any) -> BindBankOCModel {
        let dic = dic as? [String: Any]
        let result = dic?["result"]
        return BindBankOCModel.mj_object(withKeyValues: result)
    }
}
