//
//  LoginAPI.h
//  PKSQProject
//
//  Created by apple on 2019/11/23.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRequst.h"
#import "PersonalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginAPI : MyRequst

/// 登录
/// @param phone 手机号
/// @param password 密码
/// @param authToken 图片验证码
/// @param key 图片key
- (instancetype)initWithAccount:(NSString *)phone password:(NSString *)password authToken:(NSString *)authToken key:(NSString *)key;

- (PersonalModel * _Nullable)jsonForModel;

@end

NS_ASSUME_NONNULL_END
