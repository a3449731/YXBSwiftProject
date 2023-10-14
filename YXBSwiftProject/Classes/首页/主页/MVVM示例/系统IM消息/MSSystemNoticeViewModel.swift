//
//  MSSystemNoticeViewModel.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/11.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MSSystemNoticeViewModel {
    var modelArray: BehaviorRelay<[MSSystemNoticeModel]> = BehaviorRelay(value: [])
    var currentPage = 1
    let size = 2
    // 观察是否有更多数据
    var hasMoreData: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    // 网络请求数据
    func fetchData(_ closure: @escaping () -> ()) {
        currentPage = 1
        self.requetList(closure)
    }
    
    // 请求下一页数据
    func fetchNextPageData(_ closure: @escaping () -> ()) {
        self.requetList(closure)
    }
    
    private func requetList(_ closure: @escaping () -> ()) {
        let network = NetworkManager<IMAPI>()
        network.sendRequest(.systemMessageList(pageNo: currentPage, pageSize: size)) {[weak self] obj in
            guard let self = self else { return }
            let array: [MSSystemNoticeModel] = jsonToArray(jsonData: obj)
            
            if self.currentPage == 1 {
                self.modelArray.accept(array)
            } else {
                self.modelArray.accept(self.modelArray.value + array)
            }
            self.handleModel()
            // 为外界预留一个回调，不一定用得上
            closure()
            // 处理分页的要放最后
            self.handelPage(obj: obj)
        } failure: { error in
            // 为外界预留一个回调，不一定用得上
            closure()
        }
    }
    
    // 组装调整数据，调整到外界能直接使用的
    private func handleModel() {
        
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
}
