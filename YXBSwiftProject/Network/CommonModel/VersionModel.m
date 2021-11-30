//
//  VersionModel.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "VersionModel.h"

@implementation VersionModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"versionUrl" : @"url",
             @"versionNum" : @"version",
    };
}

@end
