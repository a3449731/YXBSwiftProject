//
//  GetConfigAPI.m
//  MyProject
//
//  Created by 杨 on 2/3/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "GetConfigAPI.h"

@interface GetConfigAPI ()

@property (nonatomic, copy) NSString *config;

@end

@implementation GetConfigAPI

- (instancetype)initWithConfig:(NSString *)config {
    self = [super init];
    if (self) {
        self.config = config;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/common/getConfig";
}

- (id)requestArgument {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.config forKey:@"key"];
    return dic;
}

- (NSString * _Nullable)jsonForModel {
    if ([self isValidRequestData]) {
        NSString *string = [NSString stringWithFormat:@"%@",[self.responseJSONObject valueForKey:@"data"]];
        return string;
    } else {
        return nil;
    }
}

@end
