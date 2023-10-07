//
//  LogPlugin.swift
//  MyNetWork
//
//  Created by 杨晓斌 on 2023/7/19.
//

import Moya

// MARK: 为了使用Moya自带的日志打印，进行的调整
extension NetworkLoggerPlugin {
    
    static func cteatLoggerPlugin() -> NetworkLoggerPlugin {
        
        // 整个formatter就是为了调整数据在控制台的输出内容以样式
        let formatter: NetworkLoggerPlugin.Configuration.Formatter = .init { identifier, message, target in
            if identifier == "Response" {
                // 这个字符串是HTTPURLResponse的description，从中反取url,和状态码
                if let (url, StatusCode) = parseURLAndStatusCode(description: message) {
                    return getResponseString(url: url, StatusCode: StatusCode)
                }
            }
            return "🦁进入数据 \(identifier): " + message
        } requestData: { data in
            "🦁请求数据:" + (String(data: data, encoding: .utf8) ?? "")
            
        } responseData: { data in
            // 调整键值对输出格式, 里面对键值对进行了排班
            let adjustData = responseLoggingDataFormatter(data)
            return getResonpnseBodyString(adjustData: adjustData)
        }
        
        let logOptions: NetworkLoggerPlugin.Configuration.LogOptions = [.requestMethod, .requestHeaders, .successResponseBody]
        
        let config = NetworkLoggerPlugin.Configuration(formatter: formatter, logOptions: logOptions)
        return NetworkLoggerPlugin(configuration: config)
    }
    
    // 获取时间
    static func cureentTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let timestamp = dateFormatter.string(from: Date())
        return timestamp
    }
    
    // 响应部分键值对
    static func getResponseString(url: URL?, StatusCode: Int) -> String {
        return """
------------------------------------------
\(cureentTimeString()) 🦐响应请求: \(url?.absoluteString ?? "没有解析出链接"), 状态码: \(StatusCode)
"""
    }
    
    // 具体的影响数据
    static func getResonpnseBodyString(adjustData: Data) -> String {
        return """
🐔响应数据: \((String(data: adjustData, encoding: .utf8) ?? ""))
-----------------------------------------------------
"""
    }
    
    // 调整响应的数据格式，为了让参数更好看
    static func responseLoggingDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data
        }
    }
    
    // 提取description中键值对
    static func parseURLAndStatusCode(description: String) -> (URL?, Int)? {
        let urlPattern = #"URL: (\S+)"#
        let statusCodePattern = #"Status Code: (\d+)"#
        
        if let urlRegex = try? NSRegularExpression(pattern: urlPattern, options: []),
           let statusCodeRegex = try? NSRegularExpression(pattern: statusCodePattern, options: []) {
            
            let urlRange = NSRange(location: 0, length: description.count)
            let statusCodeRange = NSRange(location: 0, length: description.count)
            
            if let urlMatch = urlRegex.firstMatch(in: description, options: [], range: urlRange),
               let statusCodeMatch = statusCodeRegex.firstMatch(in: description, options: [], range: statusCodeRange) {
                
                let urlRange = urlMatch.range(at: 1)
                let statusCodeRange = statusCodeMatch.range(at: 1)
                
                let urlString = (description as NSString).substring(with: urlRange)
                let url = URL(string: urlString)
                
                if let statusCode = Int((description as NSString).substring(with: statusCodeRange)) {
                    return (url, statusCode)
                }
            }
        }
        
        return nil
    }
}
