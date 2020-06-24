//
//  NSArray+YXBAdd.m
//  YingXingBoss
//
//  Created by 杨 on 2018/4/13.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "NSArray+YXBAdd.h"
#import "UIImage+YXBAdd.h"


@implementation NSArray (YXBAdd)

+ (NSMutableArray *)getPropertyArrayWithString:(NSString *)property inTheArray:(NSArray *)array
{
    NSMutableArray *backArray = [NSMutableArray array];
    if (property)
    {
        for (NSInteger i = 0; i < array.count; i ++)
        {
            id object = array[i];
            id pro = [object valueForKey:property];
            if (pro) {
                [backArray addObject:pro];
            }
        }
    }
    return backArray;
}


- (NSMutableArray *)imageArrayCoverToBase64ImageArray
{
    NSMutableArray *backArray = [NSMutableArray array];
    for (UIImage *image in self)
    {
        NSString *base64 = [image imageToBase64WithQuality:0.5];
        [backArray addObject:base64];
    }
    return backArray;
}

- (NSMutableArray *)imageArrayCoverToBase64ImageArrayWithTargetSize:(CGSize)size
{
    NSMutableArray *backArray = [NSMutableArray array];
    for (UIImage *image in self)
    {
        UIImage *yxb_image = [image yxb_imageByResizeToSize:size];
        NSString *base64 = [yxb_image imageToBase64WithQuality:0.5];
        [backArray addObject:base64];
    }
    return backArray;
}

- (NSMutableArray *)imageArrayCoverToBase64ImageArrayLimitMemoryMB:(CGFloat)limitMemory
{
    CGFloat everyLimit = limitMemory / self.count;
    NSMutableArray *backArray = [NSMutableArray array];
    for (UIImage *image in self)
    {
        NSString *base64String = [image coverToBase64LinmitMB:everyLimit];
        [backArray addObject:base64String];
    }
    return backArray;
}

- (NSMutableArray *)imageArrayCoverToBase64ImageArrayLimitMemoryMB:(CGFloat)limitMemory targetSize:(CGSize)size
{
    CGFloat everyLimit = limitMemory / self.count;
    NSMutableArray *backArray = [NSMutableArray array];
    for (UIImage *image in self)
    {
        NSString *base64String = [image coverToBase64LimitMemoryMB:everyLimit targetSize:size];
        [backArray addObject:base64String];
    }
    return backArray;
}


/// 拆分数组
/// @param subSize 多少个一分组
- (NSArray *)splitWithSubSize : (int)subSize {
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = self.count % subSize == 0 ? (self.count / subSize) : (self.count / subSize + 1);
    
    //用来保存指定 长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    // 利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        // 数组下标
        int index = i * subSize;
        
        // 保存拆分的固定长度的数组元素的可变数组
        
        NSMutableArray *arr1 = [ [NSMutableArray alloc] init];
        
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        
        int j = index;
        // 将数组下标乘以1、2、3,得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while (j < subSize*(i + 1) && j < self.count) {
            [arr1 addObject: [self objectAtIndex:j]];
            j += 1;
        }
        // 将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 copy]];
    }
        
    return [arr copy];
}


/// 奇数偶数分离, 奇数在前
- (NSArray *)partitionArray {
    if (self == nil) {
        return @[];
    }
    NSMutableArray *singleArray = [NSMutableArray array];
    NSMutableArray *doubleArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.count; i++) {
        if (i % 2 == 0) {
            // 奇数个
            [singleArray addObject:self[i]];
        } else {
            // 偶数个
            [doubleArray addObject:self[i]];
        }
    }
    [singleArray addObjectsFromArray:doubleArray];
    return singleArray;
}

// 纵向排列 -> 横向排列 的排序 (先补齐数组个数)
- (NSArray *)verticalToHornorRank:(NSInteger)targetCount {
    if (self == nil || self.count == 0) {
        return @[];
    }
    NSMutableArray *newArray = [self mutableCopy];
    for (NSInteger i = self.count; i < targetCount; i++) {
        [newArray addObject:[[[self.firstObject class] alloc] init]];
    }
    NSMutableArray *backArray = [NSMutableArray array];
    for (NSInteger i = 0; i < newArray.count / 2; i++) {
        [backArray addObject:newArray[i]];
        [backArray addObject:newArray[i + (newArray.count / 2)]];
    }
    return backArray;
}


@end
