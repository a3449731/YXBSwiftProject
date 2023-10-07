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
class NetworkManager<T: TargetType> {
    private let provider: NetworkProvider<T>
    
    init() {
        provider = NetworkProvider<T>()
    }
    
    // 发送请求，插件可配置，提供默认值
    func sendRequest(_ api: T,
                     defaultPlugins: [MyPluginEnum] = NetowrkPluginManager.defaultPlugins,
                     hotPlugins: [MyPluginEnum] = [],
                     success: @escaping (String) -> Void,
                     failure: ((Error) -> Void)? = nil) {
        
        privateSendRequest(api, defaultPlugins: defaultPlugins, hotPlugins: hotPlugins, success: success, failure: failure)
    }
    
    private func privateSendRequest(_ api: T,
                                    defaultPlugins: [MyPluginEnum] = [],
                                    hotPlugins: [MyPluginEnum] = [],
                                    success: @escaping (_ jsonString: String) -> Void,
                                    failure: ((Error) -> Void)?) {
        // 将插件合起来，去创建新的provider
        let plugins = (defaultPlugins + hotPlugins).map { $0 }
        provider.update(plugins: plugins)
        
        provider.request(api) { result in
            switch result {
            case .success(let response):
                do {
                    // 简单过滤下状态码和返回值
                    guard let jsonString = String(data: response.data, encoding: String.Encoding.utf8) else {
                        throw NetworkError.jsonError(url: response.request?.url?.absoluteString ?? "")
                    }
                    
                    guard 200...299 ~= response.statusCode else {
                        throw NetworkError.invalideCode(url: response.request?.url?.absoluteString ?? "")
                    }
                    
                    success(jsonString)
                    
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
private class NetworkProvider<T: TargetType> {
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
