//
//  RoomMessageTableView.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/8.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import HandyJSON

@objc class RoomMessageTableView: UIView {
    
    var modelArray: [LQMessageModel] = []
    
    @objc weak var delegate: LQMessageTableViewProtocol?
    
    lazy var tableview: UITableView = {
        let table = UITableView(frame: .zero)
        table.backgroundColor = .gray
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        // 自动计算行高
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
//        table.register(LikeGameTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "reuseHeader")
//        table.register(UINib(nibName: "LikeGameTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseCell")
        table.register(cellWithClass: LQMessageCell.self)
        table.register(cellWithClass: LQMessageTextCell.self)
        table.register(cellWithClass: LQMessageGiftCell.self)
        table.register(cellWithClass: LQMessageAiteCell.self)
        table.register(cellWithClass: LQMessageImageCell.self)
        table.register(cellWithClass: LQMessageNobbleJoinCell.self)
        table.register(cellWithClass: LQMessageNormalJoinCell.self)
        table.register(cellWithClass: LQMeesageAnnouncCell.self)
        table.register(cellWithClass: LQMeesageRoomAnnouncCell.self)
        table.register(cellWithClass: LQMeesageShangMaiCell.self)
        table.contentInsetAdjustmentBehavior = .never
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0;
        }
        
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.modelArray = self.jiashuju().map { dic in
            let model = LQMessageModel.deserialize(from: dic) ?? LQMessageModel()
            model.joinRoomAtt = model.adjustJoinRoomAtt(model: model)
            model.sendGiftAtt = model.adjustSendGiftAtt(model: model)
            model.bubbleImage = model.adjustBubbleImage(model: model)
            return model
        }
        tableview.reloadData()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}

extension RoomMessageTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.modelArray[indexPath.row]
        var cell: LQMessageCell!
        if model.type == .text {
            cell = tableView.dequeueReusableCell(withClass: LQMessageTextCell.self, for: indexPath)
        } else if model.type == .picture || model.type == .emoji {
            cell = tableView.dequeueReusableCell(withClass: LQMessageImageCell.self, for: indexPath)
        } else if model.type == .gift {
            cell = tableView.dequeueReusableCell(withClass: LQMessageGiftCell.self, for: indexPath)
        } else if model.type == .aite  {
            cell = tableView.dequeueReusableCell(withClass: LQMessageAiteCell.self, for: indexPath)
        } else if model.type == .joinRoom || model.type == .follow {
            // 进入房间,分了贵族和普通人
            if let _ = model.vipLevelInt {
                cell = tableView.dequeueReusableCell(withClass: LQMessageNobbleJoinCell.self, for: indexPath)
            } else {
                cell = tableView.dequeueReusableCell(withClass: LQMessageNormalJoinCell.self, for: indexPath)
            }
        }  else if model.type == .officialAnnouncement {
            cell = tableView.dequeueReusableCell(withClass: LQMeesageAnnouncCell.self, for: indexPath)
        }  else if model.type == .houseAnnouncement {
            cell = tableView.dequeueReusableCell(withClass: LQMeesageRoomAnnouncCell.self, for: indexPath)
        } else if model.type == .shangMai {
            cell = tableView.dequeueReusableCell(withClass: LQMeesageShangMaiCell.self, for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withClass: LQMessageCell.self, for: indexPath)
        }        
        cell.selectionStyle = .none
        cell.setup(model: model)
        cell.delegate = self
        return cell
    }
}

/// cell内的一些点击回调时间
extension RoomMessageTableView: LQMessageCellProtocol {
    // MARK:  点击了跟随
    func tableView(cell: LQMessageCell, didTapWellcomeModel: LQMessageModel) {
        if let nobbleCell = cell as? LQMessageNobbleJoinCell {
            self.makeToast("点我了贵族进入")
        }
        if let nobbleCell = cell as? LQMessageNormalJoinCell {
            self.makeToast("普通进入")
        }
        // 修改状态
        didTapWellcomeModel.hasClipWelcome = true
        if let index = self.tableview.indexPath(for: cell) {
            self.tableview.reloadRow(at: index, with: .none)
        }
        
        self.delegate?.tableViewDidTapWellcome?(model: didTapWellcomeModel)
    }
    
    // MARK: 点击了头像
    func tableView(cell: LQMessageBaseCell, didTapHeaderModel: LQMessageModel) {
        self.makeToast("点击了头像")
        self.delegate?.tableViewDidTapHeader?(model: didTapHeaderModel)
    }
}


private extension RoomMessageTableView {
    
    func jiashuju() -> [[String: Any]] {
        let dic8: [String: Any] = [
          "nickname1" : "华为4头",
          "contentWidth" : "170.000000",
          "passAction" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698648911823.mp4",
          "caiLevel" : "32",
          "nickname" : "小米",
          "headImg" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/lanqi/file/1698809513559.jpeg",
          "uid1" : "8b6c7f81b9b94c7e806738df9fa43fcc",
          "contentHeight" : "42.000000",
          "type" : "34",
          "isAdmin" : "0",
          "cellHeight" : "42.000000",
          "uid" : "58a3af31652c4ddaa4695dc1cac6784a",
          "zuoj" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698561685583.mp4",
          "shenmiren_state" : "0",
          "text" : "小米跟随华为4头进入房间",
          "meiLevel" : "51",
          "nichengbianse" : "0",
          "headKuang" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1699241355638.webp",
          "vipLevel" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698310776853.png",
          "isFz" : "0"
        ]
        
        let dic1: [String: Any] = [
          "mai" : 0,
          "vipLevel" : "",
          "contentWidth" : "100.000000",
          "passAction" : "",
          "caiLevel" : 30,
          "nickname" : "唐禹哲",
          "uname" : "唐禹哲",
          "headImg" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/36816_76574d3722784a2985a985d064a2c0dc_ios_1698902636.gif",
          "isSpeaking" : false,
          "contentHeight" : "42.000000",
          "resId" : 0,
          "type" : "11",
          "qpKuang" : "",
          "isAdmin" : "0",
          "showMai" : 0,
          "isAni" : false,
          "uid" : "76574d3722784a2985a985d064a2c0dc",
          "isGuest" : false,
          "zuoj" : "",
          "cellHeight" : "77.000000",
          "mai1" : 0,
          "uimg" : "https:\\lanqi123.oss-cn-beijing.aliyuncs.com/file/36816_76574d3722784a2985a985d064a2c0dc_ios_1698902636.gif",
          "text" : "唐禹哲进入房间",
          "meiLevel" : 54,
          "headKuang" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1699241627225.webp",
          "isLock" : false,
          "isMute" : false,
          "isFz" : "0",
          "isSelect" : false,
          "isGh": true
        ]
        
        let dic2: [String: Any] = [
            "caiLevel" : "101",
            "meiLevel" : "43",
            "isAdmin" : "0",
            "uid" : "fd56a01b47f949f5bcb1690d62f4aa8e",
            "contentHeight" : "42.000000",
            "cellHeight" : "77.000000",
            "type" : "1",
            "vipLevel" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698310776853.png",
            "isFz" : "0",
            "qpKuang" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1697867805878.png",
            "nichengbianse" : "0",
            "text" : "一个人",
            "shenmiren_state" : "0",
            "contentWidth" : "43.000000",
            "nickname" : "哈哈大笑也没哈哈大笑哈",
            "headKuang" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1699241580574.webp",
            "headImg" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/14423_fd56a01b47f949f5bcb1690d62f4aa8e_ios_1698758120.gif?x-oss-process=image/format,png"
          ]
        
        let dic5: [String: Any] = [
            "caiLevel" : "101",
            "meiLevel" : "43",
            "isAdmin" : "0",
            "uid" : "fd56a01b47f949f5bcb1690d62f4aa8e",
            "contentHeight" : "42.000000",
            "cellHeight" : "77.000000",
            "type" : "1",
            "vipLevel" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698310776853.png",
            "isFz" : "0",
            "qpKuang" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1697867805878.png",
            "nichengbianse" : "0",
            "text" : "一个人哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑是打发打发是的噶是的啊实打实也没哈哈大笑哈哈哈大笑也没哈哈大笑哈哈哈大笑也没哈哈大笑哈",
            "shenmiren_state" : "0",
            "contentWidth" : "43.000000",
            "nickname" : "哈哈大笑也没哈哈大笑哈",
            "headKuang" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1699241580574.webp",
            "headImg" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/14423_fd56a01b47f949f5bcb1690d62f4aa8e_ios_1698758120.gif?x-oss-process=image/format,png",
            "isGh": true
          ]
        
        let dic3: [String: Any] = [
            "caiLevel" : "101",
            "meiLevel" : "43",
            "vipName" : "侯爵",
            "uid" : "fd56a01b47f949f5bcb1690d62f4aa8e",
            "isAdmin" : "0",
            "contentHeight" : "59.000000",
            "cellHeight" : "94.000000",
            "passAction" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698655878856.mp4",
            "type" : "11",
            "vipLevel" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698310776853.png",
            "isFz" : "0",
            "contentWidth" : "194.000000",
            "nichengbianse" : "0",
            "shenmiren_state" : "0",
            "zuoj" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1697607971008.svga",
            "text" : "欢迎 侯爵 哈哈大笑也没哈哈大笑哈进入房间",
            "nickname" : "哈哈大笑也没哈哈大笑哈",
            "headKuang" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1699241580574.webp",
            "headImg" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/14423_fd56a01b47f949f5bcb1690d62f4aa8e_ios_1698758120.gif?x-oss-process=image/format,png"
          ]
        
        let dic4: [String: Any] = [
            "caiLevel": 101,
            "cellHeight" : "80.000000",
            "contentHeight" : "45.000000",
            "contentWidth" : "122.890234",
            "effect" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698659728075.mp4",
            "headImg" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/14423_fd56a01b47f949f5bcb1690d62f4aa8e_ios_1698758120.gif?x-oss-process=image/format,png",
            "headKuang" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1699241580574.webp",
            "img" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1695882013627.png",
            "isAdmin" : 0,
            "isFz" : 0,
            "meiLevel" : 43,
            "name" : "美少女之钥",
            "nichengbianse" : 0,
            "nickname": "哈哈大笑也没哈哈大笑哈",
            "num" : 1,
            "price" : 100,
            "shenmiren_state": 0,
            "showName" : "送给{\n    NSColor = \"UIExtendedGrayColorSpace 1 1\";\n    NSFont = \"<UICTFont: 0x10ec9da90> font-family: \\\".SFUI-Regular\\\"; font-weight: normal; font-style: normal; font-size: 14.00pt\";\n} 李维嘉1 {\n    NSColor = \"UIExtendedSRGBColorSpace 0.992157 0.843137 0.141176 1\";\n    NSFont = \"<UICTFont: 0x10ec9da90> font-family: \\\".SFUI-Regular\\\"; font-weight: normal; font-style: normal; font-size: 14.00pt\";\n}x1{\n    NSAttachment = \"<NSTextAttachment: 0x2864b8770>\";\n} x1{\n    NSColor = \"UIExtendedSRGBColorSpace 0.992157 0.843137 0.141176 1\";\n    NSFont = \"<UICTFont: 0x10ec9da90> font-family: \\\".SFUI-Regular\\\"; font-weight: normal; font-style: normal; font-size: 14.00pt\";\n}",
            "sname" : "哈哈哈哈哈哈哈哈哈哈哈哈",
            "suid" : "453993a54af94e7b8c6fe184c4fb9eb5",
            "type" : 5,
            "uid" : "fd56a01b7f949f5bcb1690d62f4aa8e",
            "vipLevel" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698310776853.png",
        ]
        
        let dic6: [String: Any] = [
          "mai" : 0,
          "vipLevel" : "",
          "vipLevelInt" : 3,
          "contentWidth" : "100.000000",
          "passAction" : "",
          "caiLevel" : 30,
          "nickname" : "唐禹哲",
          "uname" : "唐禹哲",
          "headImg" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/36816_76574d3722784a2985a985d064a2c0dc_ios_1698902636.gif",
          "isSpeaking" : false,
          "contentHeight" : "42.000000",
          "resId" : 0,
          "type" : "11",
          "qpKuang" : "",
          "isAdmin" : "0",
          "showMai" : 0,
          "isAni" : false,
          "uid" : "76574d3722784a2985a985d064a2c0dc",
          "isGuest" : false,
          "zuoj" : "",
          "cellHeight" : "77.000000",
          "mai1" : 0,
          "uimg" : "https:\\lanqi123.oss-cn-beijing.aliyuncs.com/file/36816_76574d3722784a2985a985d064a2c0dc_ios_1698902636.gif",
          "text" : "非常活泼的天使天使天使天",
          "meiLevel" : 54,
          "headKuang" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1699241627225.webp",
          "isLock" : false,
          "isMute" : false,
          "isFz" : "0",
          "isSelect" : false,
          "isGh": true
        ]
        
        let dic7: [String: Any] = [
          "mai" : 0,
          "vipLevel" : "",
          "vipLevelInt" : 4,
          "contentWidth" : "100.000000",
          "passAction" : "",
          "caiLevel" : 30,
          "nickname" : "唐禹哲",
          "uname" : "唐禹哲",
          "headImg" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/36816_76574d3722784a2985a985d064a2c0dc_ios_1698902636.gif",
          "isSpeaking" : false,
          "contentHeight" : "42.000000",
          "resId" : 0,
          "type" : "11",
          "qpKuang" : "",
          "isAdmin" : "0",
          "showMai" : 0,
          "isAni" : false,
          "uid" : "76574d3722784a2985a985d064a2c0dc",
          "isGuest" : false,
          "zuoj" : "",
          "cellHeight" : "77.000000",
          "mai1" : 0,
          "uimg" : "https:\\lanqi123.oss-cn-beijing.aliyuncs.com/file/36816_76574d3722784a2985a985d064a2c0dc_ios_1698902636.gif",
          "text" : "哈哈",
          "meiLevel" : 54,
          "headKuang" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1699241627225.webp",
          "isLock" : false,
          "isMute" : false,
          "isFz" : "0",
          "isSelect" : false
        ]
        
        let dic9: [String: Any] = [
          "mai" : 0,
          "vipLevel" : "",
          "vipLevelInt" : 4,
          "contentWidth" : "100.000000",
          "passAction" : "",
          "caiLevel" : 30,
          "nickname" : "唐禹哲",
          "uname" : "唐禹哲",
          "headImg": "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1695295116821.gif?x-oss-process=image/format,png",
//          "headImg" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/36816_76574d3722784a2985a985d064a2c0dc_ios_1698902636.gif",
          "isSpeaking" : false,
          "contentHeight" : "42.000000",
          "resId" : 0,
          "type" : "208",
          "qpKuang" : "",
          "isAdmin" : "0",
          "showMai" : 0,
          "isAni" : false,
          "uid" : "76574d3722784a2985a985d064a2c0dc",
          "isGuest" : false,
          "zuoj" : "",
          "cellHeight" : "77.000000",
          "mai1" : 0,
          "uimg" : "https:\\lanqi123.oss-cn-beijing.aliyuncs.com/file/36816_76574d3722784a2985a985d064a2c0dc_ios_1698902636.gif",
          "text" : "哈哈",
          "meiLevel" : 54,
          "headKuang" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1699241627225.webp",
          "isLock" : false,
          "isMute" : false,
          "isFz" : "0",
          "isSelect" : false,
          "atText": "@活泼的天使 "
        ]
        
        let dic10: [String: Any] = [
          "shangxiatiao" : "1",
          "cellHeight" : "74.000000",
          "text" : "哈哈大笑也没哈哈大笑哈上麦了",
          "contentWidth" : "186.000000",
          "type" : "200",
          "contentHeight" : "59.000000",
          "name" : "哈哈大笑也没哈哈大笑哈"
        ]
        
        let dic11: [String: Any] = [
          "cellHeight" : "61.000000",
          "contentWidth" : "186.000000",
          "type" : "1001",
          "contentHeight" : "46.000000",
          "text" : "官方公告：这样一个人真的可以接受自己不一样"
        ]
        
        let dic12: [String: Any] = [
          "cellHeight" : "61.000000",
          "contentWidth" : "186.000000",
          "type" : "1000",
          "contentHeight" : "46.000000",
          "text" : "欢迎来到房间，蓝鱼语音为绿色直播平台，严禁未成年人直播或打赏，禁止出现低俗色情、吸烟酗酒、封建迷信、人身伤害等违法违规内容，如主播在直播过程中以不当方式诱导打赏、私下交易，请谨慎判断，以防人身财产损失，请大家注意财产安全，谨防网络诈骗。"
        ]
        
        let dic13: [String: Any] = [
          "headKuang" : "",
          "meiLevel" : "49",
          "isAdmin" : "0",
          "uid" : "0da068bce50d48b3a2cd345b8c208dfb",
          "url" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/memePack/%E6%8A%B1%E6%8A%B1.gif",
          "type" : "207",
          "roomId" : "88760402",
          "vipLevel" : "",
          "isFz" : "0",
          "nichengbianse" : "",
          "shenmiren_state" : "",
          "nickname" : "行为都",
          "headImg" : "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1695295116821.gif?x-oss-process=image/format,png",
          "caiLevel" : "25"
        ]
        
//        return [dic12, dic11, dic8, dic1, dic10, dic6, dic9, dic2, dic13, dic7, dic3, dic4, dic5]
//        return [dic12, dic11, dic8, dic1, dic6, dic2, dic7, dic3, dic4, dic5, dic10, dic13]
        return [dic12, dic11, dic8, dic1, dic6, dic2, dic7, dic3, dic4, dic5, dic10, dic13, dic9]
//        return [dic9]
        

    }
}
