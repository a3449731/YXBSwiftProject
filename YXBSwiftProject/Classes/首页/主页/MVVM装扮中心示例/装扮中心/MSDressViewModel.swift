//
//  MSDressViewModel.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/19.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum MSDressType: Int, CaseIterable {
    /// 座驾
    case car = 1
    /// 头像框
    case header = 2
    /// 气泡框
    case bunddle = 3
    /// 麦位光圈
    case sun = 7
    /// 入场动效
    case enter = 6
    /// 背景墙
    case background = 4
    
    var title: String {
        switch self {
        case .car:
            return "座驾"
        case .header:
            return "头像框"
        case .bunddle:
            return "气泡框"
        case .background:
            return "背景墙"
        case .sun:
            return "麦位光圈"
        case .enter:
            return "入场动效"
        }
    }
}

class MSDressViewModel {
    var modelArray: BehaviorRelay<[MSDressModel]> = BehaviorRelay(value: [])
    var seletArray: BehaviorRelay<[Bool]> = BehaviorRelay(value: [])
    // 是否被全选了
    var isAllSelected: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private let disposeBag = DisposeBag()
    
    func fetchData(type: MSDressType, closure: @escaping () -> ()) {
        let network = NetworkManager<MyAPI>()
        network.sendRequest(.findZhuangbanProdList(type: type.rawValue)) { [weak self] obj in
            guard let self = self else { return }
            let array: [MSDressModel] = jsonToArray(jsonData: obj)
            self.modelArray.accept(array)
            self.seletArray.accept(Array(repeating: false, count: array.count))
            closure()
        }
    }
    
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
}
