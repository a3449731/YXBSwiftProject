//
//  GetVersionAPI.h
//  PKSQProject
//
//  Created by ShengChang on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRequst.h"
#import "VersionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetVersionAPI : MyRequst

/// APP版本信息
- (VersionModel * _Nullable)jsonForModel;

@end

NS_ASSUME_NONNULL_END
