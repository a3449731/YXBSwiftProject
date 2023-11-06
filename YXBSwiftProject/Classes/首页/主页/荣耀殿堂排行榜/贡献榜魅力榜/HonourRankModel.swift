//
//  HonourRankModel.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import HandyJSON


enum HonourRankTypeTag: String, CaseIterable {
    /// "真爱榜"
    case love = "真爱"
    /// 贡献榜
    case contribute = "贡献"
    /// "魅力榜"
    case charm = "魅力"
    
    // 传给服务器的字段。真爱绑不需要字段。
    var serverType: Int {
        switch self {
        case .love: return 0
        case .contribute: return 1
        case .charm: return 2
        }
    }
}

enum HonourRankType: String, CaseIterable {
    case day = "日榜"
    case weak = "周榜"
    case month = "月榜"
    
    // 传给接口的字段
    var timeType: Int {
        switch self {
        case .day: return 1
        case .weak: return 2
        case .month: return 3
        }
    }
}


// 荣耀排行榜
class HonourRankModel: HandyJSON {
    var nickname: String?
    var id: String?
    var cailevel: String?
    var juNum: String?
    var jueName: String?
    var isex: String?
    var headImg: String?
    var caiicon: String?
    // 神秘人
    var shenmiren_state: String?
    
    // 通过vm调整的用来展示的数据
    // 距离上一名：xxxxx
    var distanceBefore: String?
    var rank: String? // 排名
    
    required init() {}
}

//{
//  "nickname" : "嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻",
//  "id" : "20c243ef29ee4ad9a7e16684d55bb1bb",
//  "cailevel" : 19,
//  "juNum" : "80",
//  "jueName" : "帝王",
//  "isex" : "2",
//  "headImg" : "https:\/\/lanqi123.oss-cn-beijing.aliyuncs.com\/file\/1694498152667.jpg",
//  "caiicon" : ""
//}

