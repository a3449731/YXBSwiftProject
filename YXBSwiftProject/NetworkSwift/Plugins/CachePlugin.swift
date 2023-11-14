//
//  CachePlugin.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/6.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Moya
import HandyJSON

// 缓存配置
class CacheConfig {
    /// 默认不缓存
    var type: NetworkCacheType = .ignoreCache
    /// 默认30分钟内不请求
    var time: Int = 30 * 60
    
    convenience init(type: NetworkCacheType, time: Int = 30 * 60) {
        self.init()
        self.type = type
        self.time = time
    }
}

/// 缓存方式
public enum NetworkCacheType {
    /** 只从网络获取数据，且数据不会缓存在本地 */
    /** Only get data from the network, and the data will not be cached locally */
    case ignoreCache
    /** 先从网络获取数据，同时会在本地缓存数据 */
    /** Get the data from the network first, and cache the data locally at the same time */
    case networkOnly
    /** 先从缓存读取数据，如果没有再从网络获取 */
    /** Read the data from the cache first, if not, then get it from the network */
    case cacheElseNetwork
    /** 先从网络获取数据，如果没有在从缓存获取，此处的没有可以理解为访问网络失败，再从缓存读取 */
    /** Get data from the network first, if not from the cache */
    case networkElseCache
    /** 先从缓存读取数据，然后在从网络获取并且缓存，可能会获取到两次数据 */
    /** Data is first read from the cache, then retrieved from the network and cached, Maybe get `twice` data */
    case cacheThenNetwork
}

struct CachePlugin: PluginType {
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        if let api = target as? APIService {
            switch api.cacheConfig.type {
            case .networkOnly, .cacheThenNetwork, .cacheElseNetwork:
                if case let .success(response) = result {
                    // cache response
                    MyCacheManager.shared.store(response.data, for: api)
                }
            default:
                break
            }
        }
        
    }
}


class MyCacheManager {
    static let shared = MyCacheManager()
        
    private let memoryCache = NSCache<NSString, NSData>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        // 获取缓存目录路径
        let cacheDirectoryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheDirectory = cacheDirectoryURL.appendingPathComponent("NetworkCache")
        
        // 创建缓存目录
        do {
            try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Failed to create cache directory: \(error)")
        }
    }
    
    // 只保存状态码200的数据，其他数据存下来没有意义。
    func store(_ data: Data, for target: APIService) {
        if checkSuccess(data: data) {
            // 将数据存储到内存缓存
            memoryCache.setObject(data as NSData, forKey: target.identifier as NSString)
            
            // 将数据存储到文件系统
            let fileURL = cacheDirectory.appendingPathComponent(target.identifier)
            fileManager.createFile(atPath: fileURL.path, contents: data, attributes: nil)
            
            // 存储缓存过期时间
            let expirationDate = Date().addingTimeInterval(TimeInterval(target.cacheConfig.time))
            UserDefaults.standard.set(expirationDate, forKey: target.identifier)
        }
    }
    
    func fetch(for target: APIService) -> (Data?, Bool) {
        // 检查缓存是否过期
        if let expirationDate = UserDefaults.standard.object(forKey: target.identifier) as? Date {
            if expirationDate < Date() {
                // 缓存过期，返回nil和过期标志
                return (nil, true)
            }
        }
        
        // 先从内存缓存中获取数据
        if let data = memoryCache.object(forKey: target.identifier as NSString) {
#if DEBUG
            if let json = try? JSONSerialization.jsonObject(with: data as Data, options: []) {
                debugPrint( target.url, "获取到缓存数据", json)
            }
#endif
            return (data as Data, false)
        }
        
        // 从文件系统中获取数据
        let fileURL = cacheDirectory.appendingPathComponent(target.identifier)
        if fileManager.fileExists(atPath: fileURL.path) {
            let data = fileManager.contents(atPath: fileURL.path)
#if DEBUG
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                debugPrint( target.url, "获取到硬盘文件数据", json)
            }
#endif
            return (data, false)
        }
        return (nil, false)
    }
    
    // 检查是否是200
    private func checkSuccess(data: Data) -> Bool {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                let model = NetworkBasicResponse.deserialize(from: json)
                if let code = model?.code,
                   code == NetworkCode.success.rawValue {
                    return true
                }
            }
        } catch  {
            debugPrint("缓存解析错误")
        }
        return false
    }
}

