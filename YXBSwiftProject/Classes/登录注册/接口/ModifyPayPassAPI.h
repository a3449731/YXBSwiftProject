//
//  ModifyPayPassAPI.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/5.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "MyRequst.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModifyPayPassAPI : MyRequst

/// 修改支付密码
/// @param newsPass 新密码
/// @param code 短信验证码
-(instancetype)initWithOldPass:(NSString *)oldPass newsPass:(NSString *)newsPass code:(NSString *)code;

- (NSString * _Nullable)jsonForModel;

@end

NS_ASSUME_NONNULL_END
