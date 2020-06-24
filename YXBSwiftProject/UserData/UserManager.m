//
//  UserManager.m
//  PKSQProject
//
//  Created by YangXiaoBin on 2019/11/22.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "UserManager.h"

@interface UserManager ()

@end

@implementation UserManager

+ (instancetype)sharedManager {
    static UserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

@end
