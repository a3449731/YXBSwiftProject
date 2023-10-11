//
//  MyPluginManager.swift
//  MyNetWork
//
//  Created by 杨晓斌 on 2023/7/19.
//

import Moya

// MARK: 插件枚举,用枚举舒适化更方便一点
enum MyPluginEnum: Equatable, Hashable {
    case auth
//    case log // 对应Moya自带的日志插件 NetworkLoggerPlugin
    case logCustom  
    case progress // 对应Moya自带的网络加载转菊花 NetworkActivityPlugin

    var plugin: PluginType {
        switch self {
        case .auth:
            return AuthPlugin()
//        case .log:
//            return NetworkLoggerPlugin.cteatLoggerPlugin()
        case .logCustom:
            return LogCustomPlugin()
        case .progress:
            return ProgressPlugin().cteatProgressPlugin()
        }
    }

    func willSend(_ request: RequestType, target: TargetType) {
        plugin.willSend(request, target: target)
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        plugin.didReceive(result, target: target)
    }
    
    private static var token: String?
    
}


// MARK:  插件管理器,  提供默认插件
class NetowrkPluginManager {
    
    // 提供默认插件，
    static var defaultPlugins: [MyPluginEnum] = [.progress]
    
    // 常用热修复插件
    static var hotPlugins: [MyPluginEnum] = []
    
    // 或者自定义插件
    private var _customPlugins: [MyPluginEnum] = []

    var customPlugins: [MyPluginEnum] {
        return _customPlugins
    }

    func addCustomPlugin(_ plugin: MyPluginEnum) {
        _customPlugins.append(plugin)
    }

    func addCustomPlugins(_ plugins: [MyPluginEnum]) {
        _customPlugins.append(contentsOf: plugins)
    }
    
    func removeCustomPlugin(_ plugin: MyPluginEnum) {
        if let index = _customPlugins.firstIndex(where: { $0 == plugin }) {
            _customPlugins.remove(at: index)
        }
    }
}
