//
//  AcountAPI.h
//  PKSQProject
//
//  Created by ShengChang on 2019/11/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRequst.h"
#import "AcountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AcountAPI : MyRequst

@property (nonatomic, assign) BOOL isWalletHomePage;

/// 个人账户信息
- (NSArray<AcountModel *> *)jsonForModel;

@end

NS_ASSUME_NONNULL_END
