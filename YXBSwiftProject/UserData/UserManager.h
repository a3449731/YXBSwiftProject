//
//  UserManager.h
//  PKSQProject
//
//  Created by YangXiaoBin on 2019/11/22.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject

/// 单例初始化
+ (instancetype)sharedManager;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (id)copy NS_UNAVAILABLE; // 没有遵循协议可以不写
- (id)mutableCopy NS_UNAVAILABLE; // 没有遵循协议可以不写

@end

NS_ASSUME_NONNULL_END
