//
//  NoticeModel.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "NoticeModel.h"

@implementation NoticeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"noticeName" : @"noticeTitle",
             @"noticeContext" : @"noticeContent",
    };
}

@end
