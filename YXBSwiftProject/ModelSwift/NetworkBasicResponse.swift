//
//  NetworkBasicResponse.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/9.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Foundation
import HandyJSON

@objc
@objcMembers
class NetworkBasicResponse: NSObject {

    var code : Int?
    var msg : String?
    
    required override init() {}
}

@objc
class BlankContent: NSObject {
    
}

// 为HandyJson提供的泛型解析方法，用于解析遵循HandyJSON协议的模型。 不想把网络请求和解析糅合到一起，所以做了单独的。
func jsonToModel<T: HandyJSON>(jsonData: Any) -> T {
    if let json = jsonData as? [String: Any],
       let dic = json["result"] as? [String: Any] {
        let model: T = jsonToModel(dic: dic) ?? T()
        return model
    }
    return T()
}

func jsonToArray<T: HandyJSON>(jsonData: Any) -> [T] {
    if let json = jsonData as? [String: Any],
       let array = json["dataList"] as? [Any] {
        let modelArray: [T] = jsonToArray(array: array) ?? []
        return modelArray
    }
    return []
}

private func jsonToModel<T: HandyJSON>(dic: [String: Any]) -> T? {
    return T.deserialize(from: dic)
}

private func jsonToArray<T: HandyJSON>(array: [Any]) -> [T]? {
    return array.compactMap { $0 as? [String: Any] }.compactMap { T.deserialize(from: $0) }
}

// 通过当前页返回的数据，判断是否还有下一页数据
func hasNextPage(page: Int, size: Int, dic: [String: Any]) -> Bool {
    if let totalCount = dic["totalCount"] as? Int,
       let totalPage = dic["totalPage"] as? Int {
        if page > totalPage { return false }
        if page * size >= totalCount { return false }
    }
    return true
}
