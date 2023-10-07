//
//  ENV.swift
//  MyNetWork
//
//  Created by 杨晓斌 on 2023/7/19.
//

import Foundation

// 区分环境
enum Environment: String {
    case development = "测试环境"
    case production = "生产环境"
}

class Env {
    static let current = Env()
    
    let environment: Environment
    // 根据环境，配置不同所需要的网络请求常量配置
    let constants: Constants
    
    private init() {
        #if DEBUG
        self.environment = .development
        #else
        self.environment = .production
        #endif
        
        // 根据当前环境初始化 constants 属性，可以从配置文件或其他地方读取环境相关的常量值
        constants = Constants(env: environment)
    }
}

/// 常量配置
class Constants {
    let env: Environment
    required init(env: Environment) {
        self.env = env
    }
    
    var baseUrl: String {
        switch env {
        case .production: return "https://api.thecatapi.com"
        case .development: return ""
        }
    }
    // 其他环境相关的常量属性
    

}
