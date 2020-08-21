//
//  MemberModel.m
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/4.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "MemberModel.h"

@implementation MemberModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"collectProductNum" : @"goodsCollect",
             @"collectStoreNum" : @"shopCollect",
             @"inviteCode" : @"shareCode",
             @"customerId" : @"id",
//             @"customerAccount" : @"customerPhone",
    };
}

@end

