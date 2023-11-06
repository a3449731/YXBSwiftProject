//
//  HonourRankViewModel.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/27.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HonourRankViewModel {
    var currentPage = 1
    let size = 20
    // 观察是否有更多数据
    var hasMoreData: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    var modelArray_vm: BehaviorRelay<[HonourRankModel]> = BehaviorRelay(value: [])
    var modelArray: [HonourRankModel] = []
    
    
    // 网络请求数据
    func fetchData(page: HonourRankTypeTag, timeType: HonourRankType, _ closure: @escaping () -> ()) {
        currentPage = 1
        self.requetList(page: page, timeType: timeType, closure)
    }
    
    // 请求下一页数据
    func fetchNextPageData(page: HonourRankTypeTag, timeType: HonourRankType, _ closure: @escaping () -> ()) {
        self.requetList(page: page, timeType: timeType, closure)
    }
    
    private func requetList(page: HonourRankTypeTag, timeType: HonourRankType, _ closure: @escaping () -> ()) {
        let network = NetworkManager<HomeAPI>()
        
        network.sendRequest(.findRoomKingbangList(pageNo: currentPage, pageSize: size, page: page.serverType, type: timeType.timeType)) {[weak self] obj in
            guard let self = self else { return }
            let array: [HonourRankModel] = jsonToArray(jsonData: obj)
            
            if self.currentPage == 1 {
                self.modelArray = array
                self.handleModel(isFistPage: true)
            } else {
                self.modelArray = self.modelArray + array
                self.handleModel(isFistPage: false)
            }
            
            // 为外界预留一个回调，不一定用得上
            closure()
            // 处理分页的要放最后
            self.handelPage(obj: obj)
        } failure: { error in
            // 为外界预留一个回调，不一定用得上
            closure()
        }
    }
    
    
    // 处理分页
    private func handelPage(obj: Any) {
        if let dic = obj as? [String: Any] {
            let hasNext = hasNextPage(page: currentPage, size: size, dic: dic)
            if hasNext {
                currentPage += 1
            } else {
                hasMoreData.accept(false)
            }
        }
    }
    
    
    // 组装调整数据，调整到外界能直接使用的
    private func handleModel(isFistPage: Bool) {
        for (index, model) in modelArray.enumerated() {
            model.rank = "\(index + 1)"
            if let currentCounts = model.juNum?.double()?.int {
                let formattedDistance = formatDistance(currentCounts)
                model.distanceBefore = "距上名: \(formattedDistance)"
            } else {
                model.distanceBefore = ""
            }
        }
        
        if isFistPage {
            self.modelArray_vm.accept(modelArray)
        } else {
            self.modelArray_vm.accept(modelArray)
        }
    }
    
    private func formatDistance(_ distance: Int) -> String {
        if distance >= 10000 {
            let formattedDistance = String(format: "%.1fW", Double(distance) / 10000)
            return formattedDistance
        } else {
            return "\(distance)"
        }
    }
}

