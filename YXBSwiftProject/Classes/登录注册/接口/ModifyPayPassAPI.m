//
//  ModifyPayPassAPI.m
//  PKSQProject
//
//  Created by apple on 2019/11/23.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "ModifyPayPassAPI.h"

@interface ModifyPayPassAPI()

@property (copy,nonatomic) NSString *oldPass;
@property (copy,nonatomic) NSString *newsPass;
@property (copy,nonatomic) NSString *code;

@end


@implementation ModifyPayPassAPI

- (NSString *)requestUrl {
    return @"api/common/modifyPayPass";
}

-(instancetype)initWithOldPass:(NSString *)oldPass newsPass:(NSString *)newsPass code:(NSString *)code {
        self = [super init];
        if (self) {
            self.oldPass = oldPass;
            self.newsPass = newsPass;
            self.code = code;
        }
        return self;
}

- (id)requestArgument {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setValue:[UserManager sharedManager].personalInfo.account forKey:@"phone"];
    [dic setValue:self.oldPass forKey:@"oldPass"];
    [dic setValue:self.newsPass forKey:@"newPassword"];
    [dic setValue:self.code forKey:@"code"];
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
