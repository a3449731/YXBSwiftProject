//
//  NoticeAPI.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/26.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "NoticeAPI.h"

@interface NoticeAPI ()

@property (nonatomic, copy) NSString *pageNum;
@property (nonatomic, copy) NSString *pageSize;
@property (nonatomic, copy) NSString *type;

@end

@implementation NoticeAPI

- (instancetype)initWithType:(NSString *)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (instancetype)initWithPageNum:(NSString *)pageNum pageSize:(NSString *)pageSize type:(NSString *)type {
    self = [super init];
    if (self) {
        self.pageNum = pageNum;
        self.pageSize = pageSize;
        self.type = type;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/customer/selectNotice";
}

- (id)requestArgument {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.pageNum forKey:@"pageNum"];
    [dic setValue:self.pageSize forKey:@"pageSize"];
    [dic setValue:self.type forKey:@"type"];
    return dic;
}

- (NSArray<NoticeModel *> *)jsonForModel {
    if ([self isValidRequestData]) {
        return [NSArray yy_modelArrayWithClass:[NoticeModel class] json:[self.responseJSONObject valueForKey:@"data"]];
    } else {
        return @[];
    }
}

@end
