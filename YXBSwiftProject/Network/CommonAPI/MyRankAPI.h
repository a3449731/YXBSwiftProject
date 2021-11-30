//
//  MyRankAPI.h
//  PKSQProject
//
//  Created by ShengChang on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRequst.h"
#import "LevelModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyRankAPI : MyRequst

/// 我的等级
- (LevelModel * _Nullable)jsonForModel;

@end

NS_ASSUME_NONNULL_END
