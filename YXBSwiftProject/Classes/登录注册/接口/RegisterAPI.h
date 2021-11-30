//
//  RegisterAPI.h
//  PKSQProject
//
//  Created by apple on 2019/11/23.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRequst.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterAPI : MyRequst

/// 注册
/// @param phone 手机号
/// @param messsageCode 短信验证码
/// @param password 登录密码
/// @param shareCode 邀请码
/// @param paypass 支付密码
- (instancetype)initWithPhone:(NSString *)phone
                  messageCode:(NSString *)messsageCode
                     password:(NSString *)password
                    shareCode:(NSString *)shareCode
                      paypass:(NSString *)paypass;

@end

NS_ASSUME_NONNULL_END
