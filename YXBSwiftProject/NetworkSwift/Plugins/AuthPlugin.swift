//
//  AuthPlugin.swift
//  MyNetWork
//
//  Created by 杨晓斌 on 2023/7/19.
//

import Moya


struct AuthPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
//        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        request.addValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiJmZDU2YTAxYjQ3Zjk0OWY1YmNiMTY5MGQ2MmY0YWE4ZSIsImV4cCI6MTY5NzM0OTM0MH0.73rdxucbfilGiBN-soBKgY-BD0eyGEm3Om-Mzp80KOQ", forHTTPHeaderField: "apptoken")
        request.addValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIwZGEwNjhiY2U1MGQ0OGIzYTJjZDM0NWI4YzIwOGRmYiIsImV4cCI6MTY5OTY5OTM0N30.B6jdXZ4bDmipaJYQnhrBqtn7AH_93SFvCjqpvCuLbJo", forHTTPHeaderField: "apptoken")
        request.addValue("2.0.0", forHTTPHeaderField: "version")
        return request
    }
}
