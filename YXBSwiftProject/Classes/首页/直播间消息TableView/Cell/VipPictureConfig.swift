//
//  VipPictureConfig.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/11/15.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import Foundation

@objc class VipPictureConfig: NSObject {
    
    // 财富等级框
    @objc static func richBubble_oc(level: String) -> String? {
        self.richBubble(level: level)
    }
    
    static func richBubble(level: String) -> String? {
        guard let levelInt = Int(level) else { return nil}
        return self.richBubble(level: levelInt)
    }
    
    static func richBubble(level: Int) -> String? {
        if level < 0 { return nil}
        var index = level / 10 + 1
        if index > 10 {
            index = 10
        }
        return "CUYuYinFang_caifu_level_\(index)"
    }
    
    // 财富图标
    @objc static func richIcon_oc(level: String) -> String? {
        self.richIcon(level: level)
    }
    
    static func richIcon(level: String) -> String? {
        guard let levelInt = Int(level) else { return nil}
        return self.richIcon(level: levelInt)
    }
    
    static func richIcon(level: Int) -> String? {
        if level < 0 { return nil}
        var index = level / 10 + 1
        if index > 10 {
            index = 10
        }
        return "lqVipCaiFu_\(index * 10)"
    }
    
    
    // 人气等级框
    @objc static func charmBubble_oc(level: String) -> String? {
        self.charmBubble(level: level)
    }
    
    static func charmBubble(level: String) -> String? {
        guard let levelInt = Int(level) else { return nil}
        return self.charmBubble(level: levelInt)
    }
    
    static func charmBubble(level: Int) -> String? {
        if level < 0 { return nil}
        var index = level / 10 + 1
        if index > 10 {
            index = 10
        }
        return "CUYuYinFang_renqi_level_\(index)"
    }
    
    // 人气等级icon
    @objc static func charmIcon_oc(level: String) -> String? {
        self.charmIcon(level: level)
    }
    
    static func charmIcon(level: String) -> String? {
        guard let levelInt = Int(level) else { return nil}
        return self.charmIcon(level: levelInt)
    }
    
    static func charmIcon(level: Int) -> String? {
        if level < 0 { return nil}
        var index = level / 10 + 1
        if index > 10 {
            index = 10
        }
        return "lqVipRenQi_\(index * 10)"
    }
    
    
    // 贵族等级图标
    @objc static func nobleIcon_oc(level: String) -> String? {
        self.nobleIcon(level: level)
    }
    
    static func nobleIcon(level: String) -> String? {
        guard let levelInt = Int(level) else { return nil}
        return self.nobleIcon(level: levelInt)
    }
    
    static func nobleIcon(level: Int) -> String? {
        if level < 0 { return nil}
        var index = level
        if index > 7 {
            index = 7
        }
        return "CUYuYinFang_guizu_join_\(index)"
    }
    
    // 贵族等级图标
    @objc static func nobleBubble_oc(level: String) -> String? {
        self.nobleIcon(level: level)
    }
    
    static func nobleBubble(level: String) -> String? {
        guard let levelInt = Int(level) else { return nil}
        return self.nobleIcon(level: levelInt)
    }
    
    static func nobleBubble(level: Int) -> String? {
        if level < 0 { return nil}
        var index = level
        if index > 7 {
            index = 7
        }
        return "CUYuYinFang_guizu_bubble_\(index)"
    }
    
}


