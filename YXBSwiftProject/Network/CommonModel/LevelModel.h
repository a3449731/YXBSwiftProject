//
//  LevelModel.h
//  PKSQProject
//
//  Created by ShengChang on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LevelModel : YXBBaseModel

@property (nonatomic, copy) NSString *selfAmount; // 直推人数
@property (nonatomic, copy) NSString *levelName; // 星级(文字)
@property (nonatomic, copy) NSString *teamAmount; // 团队人数

@property (nonatomic, copy) NSString *teamHash; // 团队算力

@property (nonatomic, copy) NSString *convertRate; // U券 转 UE 手续费
@property (nonatomic, copy) NSString *tradeCharge; // 出售UE 手续费

@property (nonatomic, copy) NSString *selfActive; // 激活进度
@property (nonatomic, copy) NSString *needActive; // 300. 激活需要的人数
@property (nonatomic, copy) NSString *flagActive; // 是否激活分红  0:未激活


@end

NS_ASSUME_NONNULL_END
