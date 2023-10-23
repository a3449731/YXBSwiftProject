//
//  MSDressModel.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/19.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import HandyJSON

struct MSDressModel: HandyJSON {
    var texiao: String?
    var img: String?
    var isZs: String?
    var subs: [MSDressPriceModel] = []
    var id: String?
    var vipLevel: String?
    var isyy: Bool = false
    var isShou: String?
    var name: String?
    
    var price: String?
    
    // 买过了，才有的字段
    var isUsed: Bool = false
    var endTime: String?
}

struct MSDressPriceModel: HandyJSON {
    /// 2:  @"珊瑚" : 其他"鱼翅"，
    var buytype: String?
    var id: String?
    var price: String?
    
    /// 组合拳，1: 天， 2: 月   3：年   4：永久
    var type: String?
    var num: String?
}

/*
{
  "texiao" : "https:\/\/lanqi123.oss-cn-beijing.aliyuncs.com\/file\/1695798206272.svga",
  "img" : "https:\/\/lanqi123.oss-cn-beijing.aliyuncs.com\/file\/1695798203053.png",
  "isZs" : "0",
  "subs" : [
    {
      "num" : 111,
      "buytype" : "1",
      "id" : "a25f4bff812c42bea1ee93ba87115286",
      "price" : "11",
      "type" : "1"
    }
  ],
  "id" : "ad1013b75a304d2292ed3ace513c9d7d",
  "vipLevel" : 1,
  "isyy" : 0,
  "isShou" : "1",
  "name" : "AE86"
}
*/
