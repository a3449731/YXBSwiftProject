//
//  IM+API.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/11.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import Moya
import HandyJSON

/// 消息相关的接口
enum IMAPI {
    /// 系统通知列表
    case systemMessageList(pageNo: Int)
}

extension IMAPI: APIService {
    var route: APIRoute {
        switch self {
        case .systemMessageList: return .post("/api/v1/getHuMessageList")
        }
    }
    
    var parameters: APIParameters? {
        // 需要的参数和，解析方法，解析方式可以为空。
        typealias PE = (parameters: [String: Any], encoding: ParameterEncoding?)
        var result: PE = ([:], nil)
        
        switch self {
        case let .systemMessageList(pageNo):
            result.parameters = ["pageNo": String(pageNo)]
        default:
            return nil
        }
        return APIParameters(values: result.parameters, encoding: result.encoding)
    }
}
