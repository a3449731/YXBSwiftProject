//
//  MessageAPI.h
//  PKSQProject
//
//  Created by ShengChang on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRequst.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageAPI : MyRequst

/// 发送短信验证码
/// @param phone 手机号
/// @param smsType  (1注册 2忘记密码 3修改登录密码 4添加支付密码 5登录校验 6提币校验)
/// @param authToken 滑块验证的token
- (instancetype)initWithPhone:(NSString *)phone smsType:(NSString *)smsType authToken:(NSString *)authToken;

@end

NS_ASSUME_NONNULL_END
