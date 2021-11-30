//
//  NSObject+YXBAdd.m
//  BusProject
//
//  Created by 杨 on 2018/5/31.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "NSObject+YXBAdd.h"

@implementation NSObject (YXBAdd)

#pragma mark - 判断一个对象是否为空
- (BOOL)yxb_isNull
{
    if ([self isEqual:[NSNull null]]) {
        return YES;
        
    }else if ([self isEqual:[NSNull class]]){
        return YES;
    }else{
        if (self == nil) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([((NSString *)self) isEqualToString:@"(null)"]) {
            return YES;
        }
    }
    
    return NO;
}


@end
