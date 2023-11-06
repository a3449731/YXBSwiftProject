//
//  RoomListViewModel.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/26.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RoomListViewModel {
    
    var modelArray_vm: BehaviorRelay<[HomeRankModel]> = BehaviorRelay(value: [])
    var modelArray: [HomeRankModel] = []
    
    // 排行榜列表
    func fetchData(type: HomeRankTypeTag, timeType: Int, closure: @escaping () -> ()) {
        if type == .rich {
            let network = NetworkManager<HomeAPI>()
            network.sendRequest(.wealthRanking(timeType: timeType)) { [weak self] obj in
                guard let self = self else { return }
                let array: [HomeRankModel] = jsonToArray(jsonData: obj)
                self.modelArray = array
                self.handleModel()
                closure()
            } failure: { error in
                closure()
            }
        }
        if type == .live {
            let network = NetworkManager<HomeAPI>()
            network.sendRequest(.liveRanking(timeType: timeType)) { [weak self] obj in
                guard let self = self else { return }
                let array: [HomeRankModel] = jsonToArray(jsonData: obj)
                self.modelArray = array
                self.handleModel()
                closure()
            } failure: { error in
                closure()
            }
        }
        if type == .party {
            let network = NetworkManager<HomeAPI>()
            network.sendRequest(.partyRanking(timeType: timeType)) { [weak self] obj in
                guard let self = self else { return }
                let array: [HomeRankModel] = jsonToArray(jsonData: obj)
                self.modelArray = array
                self.handleModel()
                closure()
            } failure: { error in
                closure()
            }
        }
    }
    
    // 组装调整数据，调整到外界能直接使用的
    private func handleModel() {
        typealias HeaderImages = (borderImg: String?, numberImg: String?, siteImg: String?)
        
        let imageArray: [HeaderImages] = [
            HeaderImages("rank_borderImg_1", "rank_numberImg_1", "rank_siteImg_1"),
            HeaderImages("rank_borderImg_2", "rank_numberImg_2", "rank_siteImg_2"),
            HeaderImages("rank_borderImg_3", "rank_numberImg_3", "rank_siteImg_3")]
        
        for (index, model) in modelArray.enumerated() {
            // 为头3名配置图片
            if index < 3 {
                model.borderImg = imageArray[index].borderImg
                model.numberImg = imageArray[index].numberImg
                model.siteImg = imageArray[index].siteImg
            }
            
            // 当前元素的countsWealth
            guard let currentCountsWealth = model.countsWealth else {
                continue
            }
            
            // 前一个元素的countsWealth
            var previousCountsWealth: String?
            if index > 0 {
                let previousModel = modelArray[index - 1]
                previousCountsWealth = previousModel.countsWealth
            }
            
            // 计算distanceBefore的值
            if let previousCountsWealth = previousCountsWealth,
               let currentCounts = Int(currentCountsWealth),
                let previousCounts = Int(previousCountsWealth) {
                let distance = previousCounts - currentCounts
                let formattedDistance = formatDistance(distance)
                if index == 1 || index == 2 {
                    model.distanceBefore = "距上名差: \(formattedDistance)"
                } else {
                    model.distanceBefore = "距上一名差: \(formattedDistance)"
                }
            } else {
                model.distanceBefore = ""
            }
        }
        
        self.modelArray_vm.accept(modelArray)
    }
    
    private func formatDistance(_ distance: Int) -> String {
        if distance >= 10000 {
            let formattedDistance = String(format: "%.2fW", Double(distance) / 10000)
            return formattedDistance
        } else {
            return "\(distance)"
        }
    }
}
