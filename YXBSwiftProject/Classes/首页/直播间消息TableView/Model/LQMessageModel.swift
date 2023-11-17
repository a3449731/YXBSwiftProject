//
//  LQMessageModel.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/8.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import HandyJSON

enum LQMessageType: String, HandyJSONEnum {
    /// 文本
    case text = "1"
    /// 图片
    case picture = "2"
    /// 礼物
    case gift = "5"
    /// 艾特欢迎进房
    case welcome = "208"
    /// 互动 -- （暂时隐藏了）
    case hudong = "15"
    /// 跟随进房
    case aite = "32"
    /// 跟随进房
    case follow = "34"
    /// 表情
    case emoji = "207"
    /// 上麦
    case shangMai = "200"
    /// 进入房间 - 里面分为贵族 和 普通
    case joinRoom = "11"
    /// 一点开房间的提示语，官方公告
    case officialAnnouncement = "1000"
    // 房间公告
    case houseAnnouncement = "1001"
    
}


@objcMembers class LQMessageModel: NSObject, HandyJSON {
    /// 1:普通  2:图片消息  5:礼物   15:互动消息， 11,32:是@   34:跟随进房
    var type: LQMessageType?
    var contentHeight: String?
    var contentWidth: String?
    var uid: String?
    var headImg: String?
    var nickname: String?
    var text: String?
    /// 财富等级
    var caiLevel: String?
    /// 魅力等级
    var meiLevel: String?
    /// 贵族等级图片
    var vipLevel: String?
    /// 贵族等级
    var vipLevelInt: Int?
    /// 管理
    var isAdmin: String?
    /// 房主
    var isFz: String?
    /// 主持吗
    var isHost: String?
    var nichengbianse: String?
    /// 神秘人， 1:表示神秘人
    var shenmiren_state: String?
    var qpKuang: String?
    var headKuang: String?
    
    /// 发送的图片消息的 图片url
    var url: String?
    /// 这是送礼用的，这里面是富文本，是在外面拼好了丢进来的
//    var showName: NSAttributedString?
    var showName: String?
    /// 这是给11消息用的
    var nickname1: String?
    var vipName: String?
    
    /// 这是给208消息用的
    var atText: String?
    /// 礼物名称
    var name: String?
    /// 送给谁 的昵称
    var sname: String?
    /// 礼物图片
    var img: String?
    /// 礼物数量
    var num: String?
    
    /// 这是用于本地操作的，标记是否点击过欢迎按钮，点击之后就要隐藏了
    var hasClipWelcome: Bool = false
    /// 是否加入公会了，加入公会才会有欢迎按钮
//    var isGh: Bool = false
    /// 通过模型自己调整的富文本，避免cell在刷新的时候反复拼接富文本。主要服务于进入房间，跟随进房
    var joinRoomAtt: NSAttributedString?
    /// 通过模型自己调整的富文本，避免cell在刷新的时候反复拼接富文本。主要服务于送礼的富文本
    var sendGiftAtt: NSAttributedString?
    /// 通过模型自己调整的气泡的图片，避免滑动的时候还是计算图。
    var bubbleImage: UIImage?
    
    required override init() {}
    
    
    // MARK: - 这地方一定要注意，不能提前赋气泡框，气泡框的的image的实际尺寸，会导致tableviewCell自适应高度出现问题, 所以要在cell渲染差不读了再去添加图片. 或者不要去写约束，直接修改frame
    /// 请阅读注释
    func adjustBubbleImage(model: LQMessageModel) -> UIImage? {
        // 气泡还是很占位置的，过滤掉不需要气泡的类型。
        if let type = model.type {
            switch type {
            case .text, .welcome, .aite, .gift:
                break
            case .joinRoom, .picture, .hudong, .follow, .emoji, .shangMai, .officialAnnouncement, .houseAnnouncement:
                return nil
            }
        }
        
        // 制作气泡框
        var bublleName = "CUYuYinFang_roomchat_text_bg"
        if let qpKuang = model.qpKuang,
                  !qpKuang.isEmpty {
            bublleName = qpKuang
        }
        var bubbleImage: UIImage?
        if bublleName.hasPrefix("http"),
           let url = URL(string: bublleName),
           // 需要转成png拉伸才能不变形
           let image = YXBImageCache.getNetworkImage(with: url),
           let pngData = image.pngData(),
           let pngImage = UIImage(data: pngData, scale: UIScreen.main.scale)  {
            bubbleImage = pngImage
        } else {
            bubbleImage = UIImage(named: bublleName)
        }
        let width = bubbleImage?.size.width ?? 0
        let height = bubbleImage?.size.height ?? 0
        let top = height/2.0 - 0.5 // Top cap height
        let bottom = height/2.0 - 0.5 // Bottom cap height
        let left = width/2.0 - 0.5 // Left cap width
        let right = width/2.0 - 0.5 // Right cap width
        let insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        // 拉伸图片
        //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
        //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
        bubbleImage = bubbleImage?.resizableImage(withCapInsets: insets, resizingMode: .tile)
        
        return bubbleImage
    }
    
    // 调整加入房间的富文本
    func adjustJoinRoomAtt(model: LQMessageModel) -> NSAttributedString? {
        if model.type != .follow && model.type != .joinRoom {
            return nil
        }
        
        // 下面都是富文本
        let att: NSMutableAttributedString = NSMutableAttributedString()
        
        // 财富等级
        if let rich = model.caiLevel, !rich.isEmpty,
           let richLevel = Int(rich) {
            // 选择制作截图添加图片。如果是制作背景图，会因为字体宽度不一样，很难占位置。
            let richView: HonourTagView = HonourTagView(frame: CGRectMake(0, 0, 36, 16))
            richView.imageName = VipPictureConfig.richBubble(level: richLevel) ?? ""
            richView.title = rich
            richView.isOpaque = false
            UIApplication.shared.currentUIWindow()?.addSubview(richView)
            let shotImage = richView.yxb_snapshotImage()
            richView.removeFromSuperview()
                                                       
            let richAtt = NSMutableAttributedString()
            let attachment = NSMutableAttributedString.yy_attachmentString(withContent: shotImage, contentMode: .center, attachmentSize: shotImage?.size ?? CGSizeMake(10, 10), alignTo: .titleFont_14, alignment: .center)
            // 将YYTextAttachment对象插入到指定位置
            richAtt.append(attachment)
            att.append(richAtt)
            att.yy_appendString(" ")
        }
        
        // 魅力等级
        if let charm = model.meiLevel, !charm.isEmpty,
           let charmLevel = Int(charm) {
            // 选择制作截图添加图片。如果是制作背景图，会因为字体宽度不一样，很难占位置。
            let charmView: HonourTagView = HonourTagView(frame: CGRectMake(0, 0, 36, 16))
            charmView.imageName = VipPictureConfig.charmBubble(level: charmLevel) ?? ""
            charmView.title = charm
            // 不写这个的话，绘制出来会多一层黑色的背景
            charmView.isOpaque = false
            UIApplication.shared.currentUIWindow()?.addSubview(charmView)
            let shotImage = charmView.yxb_snapshotImage()
            charmView.removeFromSuperview()
                                                       
            let richAtt = NSMutableAttributedString()
            let attachment = NSMutableAttributedString.yy_attachmentString(withContent: shotImage, contentMode: .center, attachmentSize: shotImage?.size ?? CGSizeMake(10, 10), alignTo: .titleFont_14, alignment: .center)
            // 将YYTextAttachment对象插入到指定位置
            richAtt.append(attachment)
            att.append(richAtt)
            att.yy_appendString("  ")
        }
        
        let nickAtt = NSMutableAttributedString(string: model.nickname ?? "")
        nickAtt.yy_font = .titleFont_14
        nickAtt.yy_color = .titleColor_yellow
        att.append(nickAtt)
        
        // 如果是跟随某人进入的房间
        if model.type == .follow {
            let followAtt = NSMutableAttributedString(string: " 跟随 ")
            followAtt.yy_font = .titleFont_14
            followAtt.yy_color = .titleColor_white
            att.append(followAtt)
            
            // 跟谁
            if var followName = model.nickname1 {
                if followName.count > 5 {
                    let startIndex = followName.startIndex
                    let endIndex = followName.index(startIndex, offsetBy: 5)
                    followName = String(followName[startIndex..<endIndex]) + "..."
                }
                let followNameAtt = NSMutableAttributedString(string: followName)
                followNameAtt.yy_font = .titleFont_14
                followNameAtt.yy_color = .titleColor_yellow
                att.append(followNameAtt)
            }
        }
        
        let tipAtt = NSMutableAttributedString(string: " 进入了房间 ")
        tipAtt.yy_font = .titleFont_14
        tipAtt.yy_color = .titleColor_white
        att.append(tipAtt)
        
        return att
    }
    
    // 调整送礼的富文本
    func adjustSendGiftAtt(model: LQMessageModel) -> NSAttributedString? {
        if model.type != .gift {
            return nil
        }
        
        // 下面都是富文本
        let att: NSMutableAttributedString = NSMutableAttributedString()
        let sendAtt = NSMutableAttributedString(string: "送给 \(model.sname ?? "") ")
        sendAtt.yy_font = .titleFont_14
        sendAtt.yy_color = .titleColor_white
        att.append(sendAtt)
        
        let giftNameAtt = NSMutableAttributedString(string: "\(model.name ?? "") ")
        giftNameAtt.yy_font = .titleFont_14
        giftNameAtt.yy_color = .titleColor_yellow
        att.append(giftNameAtt)
        
        // 礼物图片
        if let giftUrlString = model.img,
           !giftUrlString.isEmpty,
           let giftUrl = URL(string: giftUrlString),
           let image = YXBImageCache.getNetworkImage(with: giftUrl) {
            
//            att.yy_appendString(" ")
            // 注意contentMode，大图的时候要选对模式，不然会超出
            let attachment = NSMutableAttributedString.yy_attachmentString(withContent: image, contentMode: .scaleAspectFit, attachmentSize: CGSize(width: 24, height: 24), alignTo: .titleFont_14, alignment: .center)
            att.append(attachment)
//            att.yy_appendString(" ")
        }
                
        // 数量
        let numAtt = NSMutableAttributedString(string: " x\(model.num ?? "") ")
        numAtt.yy_font = .titleFont_14
        numAtt.yy_color = .titleColor_yellow
        att.append(numAtt)
        
        return att
    }
}
