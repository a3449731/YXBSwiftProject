//
//  NSArray+IGListDiffable.m
//  YunXiaoZhi
//
//  Created by YangXiaoBin on 2019/10/24.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "NSArray+IGListDiffable.h"

@implementation NSArray (IGListDiffable)

- (id<NSObject>)diffIdentifier {
    return self;
}

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object {
    return [self isEqual:object];
}


@end
