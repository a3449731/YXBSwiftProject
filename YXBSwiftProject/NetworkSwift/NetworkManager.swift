//
//  NetworkManager.swift
//  MyNetWork
//
//  Created by 杨晓斌 on 2023/7/18.
//

import Moya

protocol MyBaseModelProtocol: Decodable {}

extension Array: MyBaseModelProtocol where Element: MyBaseModelProtocol {}

//typealias FaildHandle = (_ faildModel : NetworkBasicResponse)->Void

// 网络请求管理类
class NetworkManager<T: APIService> {
    private let provider: NetworkProvider<T>
    
    init() {
        provider = NetworkProvider<T>()
    }
    
    // 发送请求，插件可配置，提供默认值
    func sendRequest(_ api: T,
                     defaultPlugins: [MyPluginEnum] = NetowrkPluginManager.defaultPlugins,
                     hotPlugins: [MyPluginEnum] = [],
                     success: @escaping (Any) -> Void,
                     failure: ((Error) -> Void)? = nil) {
        
        privateSendRequest(api, defaultPlugins: defaultPlugins, hotPlugins: hotPlugins, success: success, failure: failure)
    }
    
    private func privateSendRequest(_ api: T,
                                    defaultPlugins: [MyPluginEnum] = [],
                                    hotPlugins: [MyPluginEnum] = [],
                                    success: @escaping (_ objc: Any) -> Void,
                                    failure: ((Error) -> Void)?) {
        // 将插件合起来，去创建新的provider
        let plugins = (defaultPlugins + hotPlugins + [.auth(token: ""), .logCustom]).map { $0 }
        provider.update(plugins: plugins)
        
        provider.request(api) { result in
            switch result {
            case .success(let response):
                do {
                    // 简单过滤下状态码和返回值
                    guard 200...299 ~= response.statusCode else {
                        throw NetworkError.invalideCode(url: response.request?.url?.absoluteString ?? "")
                    }
                    
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] {
                        // 处理Dictionary类型的数据
                        success(json)
                    } else if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [Any] {
                        // 处理Array类型的数据
                        success(json)
                    } else if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? String {
                        // 处理String类型的数据
                        success(json)
                    } else {
                        // 非String、Array、Dictionary类型的数据，进行报错处理
                        throw NetworkError.jsonError(url: response.request?.url?.absoluteString ?? "")
                    }
                    
                    //                    guard let jsonString = String(data: response.data, encoding: String.Encoding.utf8) else {
//                        throw NetworkError.jsonError(url: response.request?.url?.absoluteString ?? "")
//                    }                                        
                } catch {
                    print(error.localizedDescription)
                    failure?(error)
                }
            case .failure(let error):
                failure?(error)
            }
        }
    }
}

// 封装的MoyaProvider, 这里是真正的使用Moya配置插件，发送请求，
private class NetworkProvider<T: APIService> {
    private var provider: MoyaProvider<T>
        
    init() {
        provider = MoyaProvider<T>()
    }
    
    // 插件数组
    private(set) var plugins: Set<MyPluginEnum> = []
    
    // MARK: 在更新插件的时候重新刷新MoyaProvider, 让其能够配置正确的插件
    func update(plugins: [MyPluginEnum]) {
        self.plugins.formUnion(plugins)
        let result = self.plugins.map{ $0.plugin }
        self.provider = MoyaProvider<T>(plugins: result)
        
    }
    
    func request(_ target: T, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        provider.request(target) { result in
            completion(result)
        }
    }
}
