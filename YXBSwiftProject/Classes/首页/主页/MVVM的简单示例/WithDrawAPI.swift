//
//  WithDrawAPI.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/8.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Moya

enum WithDrawAPI {
    case bindBankCard
}

extension WithDrawAPI: APIService {
    var route: APIRoute {
        switch self {
        case .bindBankCard: return .post("/api/v3/bindBankCard")
        }
    }
    
    var parameters: APIParameters? {
        get {
            // 需要的参数和，解析方法，解析方式可以为空。
            typealias PE = (parameters: [String: Any], encoding: ParameterEncoding?)
            var result: PE = ([:], nil)
            
            switch self {
            
            default:
                return nil
            }
            return APIParameters(values: result.parameters, encoding: result.encoding)
        }
        set {
//            self.parameters = newValue
        }
    }
}
