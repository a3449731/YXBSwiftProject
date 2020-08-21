//
//  BannerModel.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"bannerId" : @"id",
             @"bannerTitle" : @"bannerTitle",
             @"bannerImage" : @"bannerImg",
             @"bannerType" : @"bannerType",
    };
}

@end
