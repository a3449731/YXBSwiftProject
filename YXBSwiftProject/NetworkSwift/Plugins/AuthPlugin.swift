//
//  AuthPlugin.swift
//  MyNetWork
//
//  Created by 杨晓斌 on 2023/7/19.
//

import Moya


struct AuthPlugin: PluginType {
    let token: String
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        return request
    }
}
