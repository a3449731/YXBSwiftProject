//
//  ToastPlugin.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/21.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import Moya
import Toast_Swift

struct ToastPlugin: PluginType {
    var needToast: Bool = true
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        if let api = target as? APIService {
            switch result {
            case .success(let response):
                do {
                    if needToast,
                       let dataAsJSON = try JSONSerialization.jsonObject(with: response.data) as? [String: Any],
                       let msg = dataAsJSON["msg"] as? String,
                       let code = dataAsJSON["code"] as? Int,
                       code != 200 {
                        UIApplication.shared.getKeyWindow()?.makeToast(msg, position: .center)
                    }
                } catch {
                    
                }
            case .failure(let error):
                debugPrint("❌ 报错了", api.url.absoluteString, error)
            }
        }
    }
}
