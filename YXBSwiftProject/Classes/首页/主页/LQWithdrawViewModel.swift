//
//  LQWithdrawViewModel.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/9.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LQWithdrawViewModel {
    var model: BindBankHandyJsonModel?
    
    // 经过调整的数据，这些可以通过RxSwift去做双向绑定。
    var showTitle: String?
    // 绑定这个属性，-1表示数据还没请求下来， 0: 不展示， 1:表示展示
    var hasZiliao: BehaviorRelay<Int> = BehaviorRelay(value: -1)
//    var hasZiliao: BehaviorSubject<Int> = BehaviorSubject(value: -1)
    func fetchData(_ closure: @escaping () -> ()) {
        let network = NetworkManager<WithDrawAPI>()
        network.sendRequest(.bindBankCard) {obj in
            self.model = jsonToModel(jsonData: obj)
            self.handleModel()
            // 为外界预留一个回调，不一定用得上
            closure()
        }
    }    
    
    // 组装调整数据，调整到外界能直接使用的
    private func handleModel() {
        self.showTitle = "银行卡号:" + (self.model?.bankName ?? "")
        self.hasZiliao.accept(self.model != nil ? 1 : 0)
//        self.hasZiliao.onNext(self.model != nil ? 1 : 0)
    }
}
