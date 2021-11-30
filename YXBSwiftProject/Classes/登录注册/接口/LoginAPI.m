//
//  LoginAPI.m
//  PKSQProject
//
//  Created by apple on 2019/11/23.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "LoginAPI.h"

@interface LoginAPI()
@property (copy,nonatomic) NSString *phone;
@property (copy,nonatomic) NSString *password;
@property (copy,nonatomic) NSString *authToken;
@property (copy,nonatomic) NSString *key;

@end


@implementation LoginAPI

- (NSString *)requestUrl {
    return @"api/common/login";
}

- (instancetype)initWithAccount:(NSString *)phone password:(NSString *)password authToken:(NSString *)authToken key:(NSString *)key {
        self = [super init];
        if (self) {
            self.phone = phone;
            self.password = password;
            self.authToken = authToken;
            self.key = key;
        }
        return self;
}

- (id)requestArgument {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.phone forKey:@"phone"];
    [dic setValue:self.password forKey:@"password"];
    [dic setValue:self.authToken forKey:@"captcha"];
    [dic setValue:self.key forKey:@"key"];
    return dic;
}

- (PersonalModel * _Nullable)jsonForModel {
    if ([self isValidRequestData]) {
        
        NSString *token = @"";
        NSString *accID = @"";
        NSString *neteaseToken = @"";
        NSString *flagAuth = @"0";
        NSString *flagChat = @"0";
        
        
        NSDictionary *dic = [self.responseJSONObject valueForKey:@"data"];
        if ([dic valueForKey:@"token"]) {
            token = [NSString stringWithFormat:@"%@",[dic valueForKey:@"token"]];
        }
        if ([dic valueForKey:@"neteaseToken"]) {
            neteaseToken = [NSString stringWithFormat:@"%@",[dic valueForKey:@"neteaseToken"]];
        }
        NSDictionary *customerDic = dic[@"customer"];
        if ([customerDic valueForKey:@"customerNumber"]) {
            accID = [NSString stringWithFormat:@"%@",[customerDic valueForKey:@"customerNumber"]];
        }
        if ([customerDic valueForKey:@"flagAuth"]) {
            flagAuth = [NSString stringWithFormat:@"%@",[customerDic valueForKey:@"flagAuth"]];
        }
        if ([customerDic valueForKey:@"flagChat"]) {
            flagChat = [NSString stringWithFormat:@"%@",[customerDic valueForKey:@"flagChat"]];
        }
        
        PersonalModel *model = [[PersonalModel alloc] init];
        model.token = token;
        model.account = self.phone;
        model.password = self.password;
        model.isLogin = YES;
        [UserManager sharedManager].personalInfo = model;
        
        MemberModel *member = [MemberModel yy_modelWithDictionary:customerDic];
        [UserManager sharedManager].memberInfo = member;
        
        return model;
    } else {
        return nil;
    }
}

@end
