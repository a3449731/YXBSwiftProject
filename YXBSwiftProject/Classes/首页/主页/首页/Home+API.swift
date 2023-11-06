//
//  Home+API.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/26.
//  Copyright © 2023 lixinkeji. All rights reserved.
//


import Moya

enum HomeAPI {
    /// 派对榜
    case partyRanking(timeType: Int)
    /// 财富榜
    case wealthRanking(timeType: Int)
    /// 直播榜
    case liveRanking(timeType: Int)
    /// 1贡献榜 2魅力榜
    case findRoomKingbangList(pageNo: Int, pageSize: Int, page: Int, type: Int)
    /// 真爱绑定
    case findTrueLoveList
}

extension HomeAPI: APIService {
    var route: APIRoute {
        switch self {
        case .partyRanking: return .get("/api/v1/partyRanking")
        case .wealthRanking: return .get("/api/v1/wealthRanking")
        case .liveRanking: return .get("/api/v1/liveRanking")
        case .findRoomKingbangList: return .post("/api/v1/findkingbangList")
        case .findTrueLoveList: return .post("api/v1/findTrueLoveList")
        }
    }
    
    var parameters: APIParameters? {
        // 需要的参数和，解析方法，解析方式可以为空。
        typealias PE = (parameters: [String: Any], encoding: ParameterEncoding?)
        var result: PE = ([:], nil)
        
        switch self {
        case let .partyRanking(timeType):
            result.parameters = ["timeType": timeType]
        case let .wealthRanking(timeType):
            result.parameters = ["timeType": timeType]
        case let .liveRanking(timeType):
            result.parameters = ["timeType": timeType]
        case let .findRoomKingbangList(pageNo, pageSize, page, type):
            result.parameters = ["pageNo": String(pageNo),
                                 "pageSize": String(pageSize),
                                 "cate": String(page),
                                 "type": String(type)]
        case .findTrueLoveList:
            result.parameters = [:]
        default:
            return nil
        }
        return APIParameters(values: result.parameters, encoding: result.encoding)
    }
}
