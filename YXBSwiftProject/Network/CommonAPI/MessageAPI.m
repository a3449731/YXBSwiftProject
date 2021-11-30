//
//  MessageAPI.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MessageAPI.h"

@interface MessageAPI ()

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *smsType;
@property (nonatomic, copy) NSString *authToken;

@end

@implementation MessageAPI

- (instancetype)initWithPhone:(NSString *)phone smsType:(NSString *)smsType authToken:(NSString *)authToken {
    self = [super init];
    if (self) {
        self.phone = phone;
        self.smsType = smsType;
        self.authToken = authToken;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/common/getSmsCode";
}

- (id)requestArgument {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.phone forKey:@"phone"];
    [dic setValue:self.smsType forKey:@"smsType"];
    [dic setValue:self.authToken forKey:@"authToken"];
    return dic;
} 

@end
