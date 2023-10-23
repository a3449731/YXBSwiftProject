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
    
    /// Called immediately before a request is sent over the network (or stubbed). 发送之前做加密
    func willSend(_ request: RequestType, target: TargetType) {        
        if var api = target as? APIService,
           let originalDictionary = api.parameters?.values{
            
            let sign = IPNRSAUtil.queryMD5String(originalDictionary)
            var mutableDictionary = originalDictionary
            mutableDictionary["sign"] = sign
//            var dic: [String: AnyObject] = [:]
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: mutableDictionary, options: []) {
                let encryptString = String(data: jsonData, encoding: .utf8) ?? ""
                
//                let encryptString = IPNRSAUtil.encryptString(jsonString, publicKey: "")
//                let encryptedParameters = ["data": encryptString]
//                api.parameters?.values = encryptedParameters
                
                let encryptedParameters = ["data": encryptString]
//                api.parameters?.values = encryptedParameters
//                api.parameters = APIParameters(values: encryptedParameters, encoding: api.parameters?.encoding)
//                api.parameters?.values = encryptedParameters
            }
            
//            let encryptString = IPNRSAUtil.encryptString(mutableDictionary.mj_JSONString(), publicKey: "")
//            let encryptedParameters = ["data": encryptString]
//            api.parameters.values = encryptedParameters
            
        }
        
    }
    
    
    ///  before completion. 完成之前进行解密
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        return result
    }
}
