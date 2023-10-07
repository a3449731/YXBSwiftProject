//
//  MyError.swift
//  MyNetWork
//
//  Created by 杨晓斌 on 2023/7/19.
//

import Moya

enum NetworkError: LocalizedError {
    case invalideCode(url: String)
    case jsonError(url: String)
    
    var errorDescription: String? {
        switch self {
        case .invalideCode(let url): return "❌ \(url)  返回状态码不合规"
        case .jsonError(let url): return "❌ \(url)  返回非法Json数据"
        }
    }
}

