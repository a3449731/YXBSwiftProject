//
//  ForgetPassAPI.m
//  PKSQProject
//
//  Created by apple on 2019/11/23.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "ForgetPassAPI.h"

@interface ForgetPassAPI()
@property (copy,nonatomic) NSString *phone;
@property (copy,nonatomic) NSString *password;
@property (copy,nonatomic) NSString *code;

@end


@implementation ForgetPassAPI

- (NSString *)requestUrl {
    return @"api/common/forgetPass";
}

- (instancetype)initWithAccount:(NSString *)phone password:(NSString *)password code:(NSString *)code {
        self = [super init];
        if (self) {
            self.phone = phone;
            self.password = password;
            self.code = code;
        }
        return self;
}

- (id)requestArgument {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.phone forKey:@"phone"];
    [dic setValue:self.password forKey:@"password"];
    [dic setValue:self.code forKey:@"code"];
    [dic setValue:@"1" forKey:@"captcha"];
    [dic setValue:@"1" forKey:@"key"];
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
