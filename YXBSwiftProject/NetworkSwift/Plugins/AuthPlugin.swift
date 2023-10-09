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
//        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        request.addValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiJmZDU2YTAxYjQ3Zjk0OWY1YmNiMTY5MGQ2MmY0YWE4ZSIsImV4cCI6MTY5NzM0OTM0MH0.73rdxucbfilGiBN-soBKgY-BD0eyGEm3Om-Mzp80KOQ", forHTTPHeaderField: "apptoken")
        request.addValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiI5MmM1NDQ0NTQwMWE0Nzc0YjUyZDg4YzlmNGI4YWEzZSIsImV4cCI6MTY5NzQyNDE2Mn0.Bs0ahb2h7sqpvRv1G9DRCRpsTDBiyDPHkJuNbSx5BPM", forHTTPHeaderField: "apptoken")
        return request
    }
}
