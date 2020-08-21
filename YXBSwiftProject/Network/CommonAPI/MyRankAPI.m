//
//  MyRankAPI.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRankAPI.h"

@implementation MyRankAPI

- (NSString *)requestUrl {
    return @"api/customer/selectMyRank";
}

- (LevelModel * _Nullable)jsonForModel {
    if ([self isValidRequestData]) {
        LevelModel *model = [LevelModel yy_modelWithJSON:[self.responseJSONObject valueForKey:@"data"]];
        return model;
    } else {
        return nil;
    }
}

@end
