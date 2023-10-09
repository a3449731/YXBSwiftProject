//
//  APIServer.swift
//  MyNetWork
//
//  Created by 杨晓斌 on 2023/7/19.
//

import Moya


protocol APIService: TargetType {
    
    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: Moya.Method { get }

    /// Provides stub data for use in testing.
    var sampleData: Data { get }

    /// The type of HTTP task to be performed.
    var task: Task { get }

    /// The type of validation to perform on the request. Default is `.none`.
    var validationType: ValidationType { get }

    /// The headers to be used in the request.
    var headers: [String: String]? { get }
    
    var parameters: APIParameters? { get }
    /// API 路由和 HTTP 方法，不包含域名、服务名和版本号，
    ///
    /// 如一个 GET API 完整地址为 http://xx.com/message/v1/group/create
    /// 这里返回
    /// ```
    /// .get("/group/create")
    /// ```
    var route: APIRoute { get }
}



extension APIService {
    var url: URL {
        path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
    }
    
    var baseURL: URL {
        URL(string: Env.current.constants.baseUrl + servicePath)!
    }
    
    var servicePath: String {
        ""
    }
    
    var headers: [String: String]? {
        [
            "Accept": "*/*",
            "Content-Type": "application/x-www-form-urlencoded; application/json; text/plain",            
        ]
    }
    
    var sampleData: Data {
        fatalError("sampleData has not been implemented")
    }
    
    var task: Task {
        guard let params = self.parameters?.values else {
            return .requestPlain
        }
        let defaultEncoding: ParameterEncoding = self.method == .get ? URLEncoding.queryString : JSONEncoding.default
        return .requestParameters(parameters: params, encoding: self.parameters?.encoding ?? defaultEncoding)
    }
    
    
    var route: APIRoute {
        fatalError("route has not been implemented")
    }
    
    var path: String {
        NSString.path(withComponents: [self.route.path])
    }
    
    var method: Moya.Method {
        route.method
    }
    
    var parameters: APIParameters? {
        nil
    }
    
    var identifier: String {
        route.method.rawValue + url.absoluteString
    }
    
    func makeHeaders() -> [String: String]? {
        var headers = self.headers ?? ["Accept": "application/json;application/x-www-form-urlencoded"]
//        if method == .get || method == .head || method == .delete {
//            headers["Content-Type"] = contentType ?? "application/json"
//        } else {
            headers["Content-Type"] = "application/x-www-form-urlencoded"
//        }
        return headers
//        return headers
    }
}

/// `APIProviderSharing` 为所有的 `APIService` 提供了一个
/// `APIProvider` 的单例用于执行请求和管理内部状态
//protocol APIProviderSharing where Self: APIService {
//    static var shared: APIProvider<Self> { get }
//    func make(_ duringOfObject: AnyObject?, behaviors: Set<APIRequestBehavior>?, hotPlugins: [APIPlugin]) -> SignalProducer<APIResult, APIError>
//}
