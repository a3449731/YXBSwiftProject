//
//  GetConfigAPI.h
//  MyProject
//
//  Created by 杨 on 2/3/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "MyRequst.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetConfigAPI : MyRequst

/// 获取配置
- (instancetype)initWithConfig:(NSString *)config;

- (NSString * _Nullable)jsonForModel;

@end

NS_ASSUME_NONNULL_END
