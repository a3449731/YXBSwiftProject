//
//  AcountModel.h
//  PKSQProject
//
//  Created by ShengChang on 2019/11/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AcountModel : YXBBaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *purseAddress; // 钱包地址
@property (nonatomic, copy) NSString *useCoin; // DMO
@property (nonatomic, copy) NSString *useMoney; // DMO资产
@property (nonatomic, copy) NSString *usePoint; // 消费卷
@property (nonatomic, copy) NSString *useUsdt; // USDT
@property (nonatomic, copy) NSString *lockUsdt; // USDT资产
@property (nonatomic, copy) NSString *lockMoney; // 生态矿池

@end

NS_ASSUME_NONNULL_END
