//
//  HonourLoveModel.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/28.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import HandyJSON

// 真爱排行榜
class HonourLoveModel: HandyJSON {
    var uid: HonourRankModel?
    var fromId: HonourRankModel?
    var dactMiz: String?
    
    var houseName: String?
    // 礼物图片
    var giftUrl: String?
    // 后台是时间戳，自己转化一下。
    var rewardDate: String?
    
    
    var attString: NSAttributedString?
    
    required init() {}
}

//{
//    "uid": "{\"caiicon\":\"\",\"headImg\":\"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1694336727563.png\",\"shenmiren_state\":\"0\",\"cailevel\":1,\"nickname\":\"吴尊\",\"id\":\"251f2a07cc8142afa15444d2df4a3b43\",\"isex\":\"1\"}",
//    "fromId": "{\"caiicon\":\"\",\"headImg\":\"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/59940_92c54445401a4774b52d88c9f4b8aa3e_ios_1695883743.png\",\"shenmiren_state\":\"0\",\"cailevel\":103,\"nickname\":\"一心只想下班\",\"jueName\":\"帝王\",\"id\":\"92c54445401a4774b52d88c9f4b8aa3e\",\"isex\":\"1\"}",
//    "dactMiz": "1111.00"
//},
