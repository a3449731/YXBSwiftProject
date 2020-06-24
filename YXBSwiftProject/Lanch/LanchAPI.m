//
//  LanchAPI.m
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/2.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "LanchAPI.h"

@implementation LanchAPI

- (NSString *)requestUrl {
    return @"";
}

- (NSString *)baseUrl {
    return @"";
}

- (LanchPageModel * _Nullable)jsonForModel; {
    if ([self isValidRequestData]) {
        LanchPageModel *model = [LanchPageModel yy_modelWithJSON:[self.responseJSONObject valueForKey:@"data"]];
        return model;
    } else {
        return nil;
    }
}

@end
