//
//  APIParameters.swift
//  MyNetWork
//
//  Created by 杨晓斌 on 2023/7/19.
//

import Moya

struct APIParameters {
    let values: [String: Any]
    let encoding: ParameterEncoding? // 假设此处的 ParameterEncoding 是 Moya 中的一种编码方式
}

extension APIParameters {
    // 可以根据需要扩展其他初始化方法
    
    // 初始化一个没有参数的 APIParameters
    static var empty: APIParameters {
        return APIParameters(values: [:], encoding: JSONEncoding.default)
    }
    
    // 根据具体参数和编码方式初始化 APIParameters
    static func from(values: [String: Any], encoding: ParameterEncoding) -> APIParameters {
        return APIParameters(values: values, encoding: encoding)
    }
}
