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
    
    // 网络请求数据
    func fetchData(_ closure: @escaping () -> ()) {
        let network = NetworkManager<IMAPI>()
        network.sendRequest(.systemMessageList(pageNo: 1)) {[weak self] obj in
            guard let self = self else { return }
            
            let array: [MSSystemNoticeModel] = jsonToArray(jsonData: obj)
            self.modelArray.accept(array)
            
            self.handleModel()
            
            // 为外界预留一个回调，不一定用得上
            closure()
        }
    }
    
    // 组装调整数据，调整到外界能直接使用的
    private func handleModel() {
        
    }
}
