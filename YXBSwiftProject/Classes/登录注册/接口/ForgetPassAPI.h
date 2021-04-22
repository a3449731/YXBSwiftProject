//
//  ForgetPassAPI.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/5.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "MyRequst.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForgetPassAPI : MyRequst

/// 忘记密码
/// @param phone 手机号
/// @param password 新密码
/// @param code 短信验证码
- (instancetype)initWithAccount:(NSString *)phone password:(NSString *)password code:(NSString *)code;

- (NSString * _Nullable)jsonForModel;

@end

NS_ASSUME_NONNULL_END
