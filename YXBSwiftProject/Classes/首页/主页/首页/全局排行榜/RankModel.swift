//
//  RankModel.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/26.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import HandyJSON

//// 排行榜模型
//class RankModel: HandyJSON {
//
//    var headPicture: String? // 头像
//    var nickname: String? // 昵称
//    var score: String? // 分数, 首页排行榜不用这个，展示距上一名用户的差距
//    /// 差上一名多少
//    var almostUpAwayScore: String?
//    var userId: String? // 用户id
//    
//    var image: String? // 爵位图片
//    var headPictureSmall: String? // 爵位小图标
//    var headPictureBig: String? // 爵位大图标
//    
//    var nobilityName: String? // 爵位名字
//    
//    var onLine: String? // 1: 在线 2:不在线
//    
//    // 标记辉煌还是殿堂
//    var typeTag: RoomRankTypeTag = .glory
//    
//    enum RoomRankTypeTag: Int, HandyJSONEnum {
//        
//        /// "心动堂"
//        case charm = 1
//        /// "辉煌殿堂"
//        case glory = 2
//        
//        var title: String {
//            switch self {
//            case .charm: return "心动值"
//            case .glory: return "辉煌值"
//            }
//        }
//    }
//    
//    required init() {}
//}

enum HomeRankTypeTag: String, CaseIterable {
    /// "财富榜"
    case rich = "财富榜"
    /// 直播榜
    case live = "直播榜"
    /// "派对榜"
    case party = "派对榜"
    
    
    var tipTitle: String {
        switch self {
        case .rich: return "财富榜规则"
        case .live: return "直播榜规则"
        case .party: return "派对榜规则"
        }
    }
    
    var tipTitleColor: UIColor? {
        switch self {
        case .rich: return UIColor(hex: 0xFFA300)
        case .live: return UIColor(hex: 0x3663FB)
        case .party: return UIColor(hex: 0xFF59CE)
        }
    }
    
    var tipImage: String {
        switch self {
        case .rich: return "rank_tip_background_1"
        case .live: return "rank_tip_background_2"
        case .party: return "rank_tip_background_3"
        }
    }
    
    var tipContent: String {
        switch self {
        case .rich :
            let tip = """

            1. 财富榜积分为 在平台每充值1鱼翅积1分， 每日首次开启app积1分，综合累计排名


            2. 日榜每天零点重新计算，周榜每自然周为一个统计维度，月榜每自然月为一个统计维度

    """
            return tip
        case .live:
            let tip = """

            1. 直播榜积分为 主播每收到1鱼翅积1分，每日首次开启app积1分，综合累计排名


            2. 日榜每天零点重新计算，周榜每自然周为一个统计维度，月榜每自然月为一个统计维度

    """
            return tip
        case .party:
            let tip = """

            1. 派对榜积分为 陪陪每收到1鱼翅积1分，每日首次开启app积1分，综合累计排名


            2. 日榜每天零点重新计算，周榜每自然周为一个统计维度，月榜每自然月为一个统计维度

    """
            return tip
        }
    }
}


enum RankType: String {
    case day = "今日榜"
    case weak = "本周榜"
    case month = "本月榜"
    
    // 传给接口的字段
    var timeType: Int {
        switch self {
        case .day: return 1
        case .weak: return 2
        case .month: return 3
        }
    }
}

// 首页排行榜
class HomeRankModel: HandyJSON {
    
    var rank: String? // 排名
    var countsWealth: String? // 距上一名
    var type: String?
    // 把房间的映射到nickname，和headImg了。统一处理方便先
    var title: String? // 房间标题
    var houseImg: String? // 房间图片
    /// 当存在房间号，点击是直接跳转到房间，其他时候是跳转个人资料页
    var houseNo: String?
    
    // 用户id
    var roomauthorid: String?
    var nickname: String?  // 昵称
    var headImg: String? // 头像
    // 用户号，暂时不用
    var custNo: String?
    var isex: SexType = .male
            
    
    // 通过vm调整的用来展示的数据
    // 距离上一名：xxxxx
    var distanceBefore: String?
    // 背景框
    var borderImg: String?
    var numberImg: String?
    /// 下面的1,2,3
    var siteImg: String?
    
    required init() {}
    
    func didFinishMapping() {
        if self.title != nil && self.title!.isEmpty == false {
            self.nickname = self.title
        }
        if self.houseImg != nil && self.houseImg!.isEmpty == false {
            self.headImg = self.houseImg
        }
    }
}


//{
//  "rank": 1,
//  "countsWealth": 12244,
//  "type": "3",
//  "title": "555",
//  "houseImg": "https://lanqi123.oss-cn-beijing.aliyuncs.com/lanqi/file/1697450943858.gif",
//  "houseNo": "23614776"
//}
//{
//  "rank": 1,
//  "countsWealth": 12244,
//  "roomauthorid": "eaf0f00be1434f1f8258a2ed31887d00",
//  "nickname": "吴昕",
//  "headImg": "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/97634_eaf0f00be1434f1f8258a2ed31887d00_ios_1697871727.png",
//  "custNo": "23614776",
//  "isex": "2"
//}
