//
//  MSDressBuyViewModel.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/20.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MSDressBuyViewModel {
    // 最终可以直接用来展示的数据
    var modelArray: BehaviorRelay<[MSDressBuyShowModel]>  = BehaviorRelay(value: [])
    var seletArray: BehaviorRelay<[Bool]> = BehaviorRelay(value: [])
    // 是否被全选了
    var isAllSelected: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private let disposeBag = DisposeBag()
    
    init() {
        // 为isAllSelected监听，
        seletArray
            .debug()
            .map { array in
                // 判断是否全为true
                array.allSatisfy { $0 }
            }
            .bind(to: isAllSelected)
            .disposed(by: disposeBag)
    }
    
    func fetchData(model: MSDressModel, closure: @escaping () -> ()) {
        let showArray = handleData(array: model.subs)
        self.modelArray.accept(showArray)
        self.seletArray.accept(Array(repeating: false, count: model.subs.count))
        closure()
    }
    
    /// 买装扮
    func requestBuyDress(zbId: String, subId: String, _ closure: @escaping () -> ()) {
        let network = NetworkManager<MyAPI>()
        network.sendRequest(.userbyZhuangbanPay(zbId: zbId, subId: subId)) { obj in
            closure()
        } failure: { error in
            closure()
        }
    }
    
    // 处理到能直接使用的数据
    private func handleData(array: [MSDressPriceModel]) -> [MSDressBuyShowModel] {
        let showArray = array.map { item in
            var tempModel = MSDressBuyShowModel()
            tempModel.id = item.id
            tempModel.time = ""
            if item.type == "1" {
                tempModel.time = "\(item.num ?? "")天"
            }
            if item.type == "2" {
                tempModel.time = "\(item.num ?? "")月"
            }
            if item.type == "3" {
                tempModel.time = "\(item.num ?? "")年"
            }
            if item.type == "4" {
                tempModel.time = "永久"
            }
            
            tempModel.price = item.price
            
            if item.buytype == "2" {
                tempModel.priceString = "\(item.price ?? "") 珊瑚"
            } else {
                tempModel.priceString = "\(item.price ?? "") 鱼翅"
            }
            return tempModel
        }
        return showArray
    }
}

// 这里是经过调整后，对外直接使用的数据模型
struct MSDressBuyShowModel {
    var price: String?
    var priceString: String?
    var time: String?
    var id: String?
}
