//
//  RegisterAPI.m
//  PKSQProject
//
//  Created by apple on 2019/11/23.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "RegisterAPI.h"

@interface RegisterAPI ()

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *messsageCode;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *shareCode;
@property (nonatomic, copy) NSString *paypass;

@end

@implementation RegisterAPI

- (instancetype)initWithPhone:(NSString *)phone
                  messageCode:(NSString *)messsageCode
                     password:(NSString *)password
                    shareCode:(NSString *)shareCode
                    paypass:(NSString *)paypass {
    
    self = [super init];
    if (self) {
        self.phone = phone;
        self.messsageCode = messsageCode;
        self.password = password;
        self.shareCode = shareCode;
        self.paypass =paypass;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"api/common/registerUser";
}

- (id)requestArgument {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.phone forKey:@"account"];
    [dic setValue:self.password forKey:@"password"];
    [dic setValue:self.messsageCode forKey:@"code"];
    [dic setValue:self.shareCode forKey:@"shareCode"];
    [dic setValue:self.paypass forKey:@"payPass"];
    return dic;
}

@end
