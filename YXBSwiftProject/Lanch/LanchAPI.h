//
//  LanchAPI.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/2.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "MyRequst.h"
#import "LanchPageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LanchAPI : MyRequst

/// 广告页数据，里面的URL自己配置,模型自行更改,对号入座
- (LanchPageModel * _Nullable)jsonForModel;

@end

NS_ASSUME_NONNULL_END
