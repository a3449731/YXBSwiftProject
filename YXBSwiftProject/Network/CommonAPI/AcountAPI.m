//
//  AcountAPI.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "AcountAPI.h"
#import "AcountModel.h"

@implementation AcountAPI

- (NSString *)requestUrl {
    return @"api/customer/selectAccount";
}

- (NSArray *)jsonForModel {
    if ([self isValidRequestData]) {
        AcountModel *model = [AcountModel yy_modelWithJSON:[self.responseJSONObject valueForKey:@"data"]];
        [UserManager sharedManager].acoutModel = model;
        return @[model];
    } else {
        return @[];
    }
}

@end
