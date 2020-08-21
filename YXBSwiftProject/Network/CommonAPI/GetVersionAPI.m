//
//  GetVersionAPI.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "GetVersionAPI.h"
#import "VersionModel.h"

@implementation GetVersionAPI

- (NSString *)requestUrl {
    return @"api/common/getVersion";
}

- (id)requestArgument {
    // 应该是这样 apple_version:ios  android_version:安卓
    return @{@"key":@"apple_version"};
}

- (VersionModel * _Nullable)jsonForModel {
    if ([self isValidRequestData]) {
        VersionModel *model = [VersionModel yy_modelWithJSON:[self.responseJSONObject valueForKey:@"data"]];
        [UserManager sharedManager].versionModel = model;
        return model;
    } else {
        return nil;
    }
}

@end
