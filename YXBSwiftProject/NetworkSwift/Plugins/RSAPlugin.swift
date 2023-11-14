//
//  RSAPlugin.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/18.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import Moya
import MJExtension
//NSString *sign = [IPNRSAUtil queryMD5String:originalDictionary];
//NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
//mutableDic[@"sign"] = sign;
//NSString *encryptString = [IPNRSAUtil encryptString:mutableDic.mj_JSONString publicKey:@""];
//@{@"data": encryptString};

struct RSAPlugin: PluginType {
    
    // 要在这里面对 入参进行rsa加密
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        // 空参数不加密
        guard let requstData = request.httpBody else {
            return request
        }
        
        var parameters : [AnyHashable: Any]? = [:]
        do {
            let json = try JSONSerialization.jsonObject(with: requstData, options: .mutableContainers)
            parameters = json as? [AnyHashable: Any]
        } catch  {
            
        }
        
        // 加密之后的参数
        parameters = IPNRSAUtil.signAndSecret(parameters)
        
//        let prama = IPNRSAUtil.signAndSecret(["zbId": "54a6d28eec1c4c9f8c8192368e58ece4",
//                                              "subId": "cbe695f55f724782987dfd12b7f091e4"])
                
        if let api = target as? APIService {
            debugPrint("加密接口", api.url, parameters)
        }
        
        // 替换原本的body
        let encryptedData = parameters?.jsonData()
        var updatedRequest = request
        updatedRequest.httpBody = encryptedData
        return updatedRequest
    }
    
    
    ///  before completion. 完成之前进行解密
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        return result
    }
    
    /// Called to modify a result before completion.
//    public func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
//        
//        /// 验签
//        if case .success(let response) = result {
//            do {
//                let responseString = try response.mapJSON()
//                
//                /// Json 转成 字典
//                let dic =  JsonToDic(responseString)
//                
//                /// 验签
//                if let _ = SignUntil.verifySign(withParamDic: dic) {
//                    
//                    /// 数据解密
//                    dic = RSA.decodeRSA(withParamDic: dic)
//                    
//                    /// 重新生成 Moya.response
//                    /// ...
////                    Moya.Response(statusCode: <#T##Int#>, data: <#T##Data#>, request: <#T##URLRequest?#>, response: <#T##HTTPURLResponse?#>)
//
//                    /// 返回 Moya.response
//                    return .success(response)
//                } else {
//                    let error = NSError(domain: "验签失败", code: 1, userInfo: nil)
//                    return .failure(MoyaError.underlying(error, nil))
//                }
//            } catch {
//                let error = NSError(domain: "拦截器 response 转 json 失败", code: 1, userInfo: nil)
//                return .failure(MoyaError.underlying(error, nil))
//            }
//        } else {
//            /// 原本就失败了就丢回了
//            return result
//        }
//    }

}
