//
//  HonourLoveViewModel.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HonourLoveViewModel {
    
    var modelArray_vm: BehaviorRelay<[HonourLoveModel]> = BehaviorRelay(value: [])
    var modelArray: [HonourLoveModel] = []
    
    // 排行榜列表
    func fetchData(closure: @escaping () -> ()) {
        let network = NetworkManager<HomeAPI>()
        network.sendRequest(.findTrueLoveList) { [weak self] obj in
            guard let self = self else { return }
            let array: [HonourLoveModel] = jsonToArray(jsonData: obj)
            self.modelArray = array
            self.handleModel()
            closure()
        } failure: { error in
            closure()
        }
    }
    
    // 组装调整数据，调整到外界能直接使用的
    private func handleModel() {

        for (index, model) in modelArray.enumerated() {
            if let fromId = model.fromId,
               let fromNickname = fromId.nickname,
               let uid = model.uid,
               let uidNickname = uid.nickname {
                
                let attributedString = NSMutableAttributedString()
                
                let leftString = NSAttributedString(string: fromNickname,
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x333333)!,
                                                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
                attributedString.append(leftString)
                
                let middleString = NSAttributedString(string: " 打赏 ",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0xFF4D73)!,
                                                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
                attributedString.append(middleString)
                
                let rightString = NSAttributedString(string: uidNickname,
                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x333333)!,
                                                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
                attributedString.append(rightString)
                
                model.attString = attributedString
            }
            
            // 处理时间
            if let time = model.rewardDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 设置日期格式，根据实际情况进行调整
                // 将时间戳字符串转换为NSDate对象
                if let timestamp = TimeInterval(time) {
                    let date = Date(timeIntervalSince1970: timestamp / 1000.0)
                    // 将NSDate对象转换为指定格式的字符串
                    let dateString = dateFormatter.string(from: date)
                    model.rewardDate = NSString.formateDate(dateString, withFormate: "yyyy-MM-dd HH:mm:ss")
                    print(dateString)
                }
            }
            
        }
        
    }
}
