//
//  NSArray+YXBAdd.h
//  YingXingBoss
//
//  Created by 杨 on 2018/4/13.
//  Copyright © 2018年 杨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YXBAdd)


/**
 抽取 model数组的一个属性 ,组成数组.

 @param property 要抽取的属性
 @param array 模型数组
 @return 返回 单一属性数组
 */
+ (NSMutableArray *)getPropertyArrayWithString:(NSString *)property inTheArray:(NSArray *)array;

/// 拆分数组
/// @param subSize 多少个一分组
- (NSArray *)splitWithSubSize : (int)subSize;

/// 奇数偶数分离, 奇数在前
- (NSArray *)partitionArray;

// 纵向排列 -> 横向排列 的排序 (先补齐数组个数)
- (NSArray *)verticalToHornorRank:(NSInteger)targetCount;


/**
 图片数组 转成base64数组
 @return base64数组
 */
- (NSMutableArray *)imageArrayCoverToBase64ImageArray;



/**
 修改图片宽高。再转化成base64

 @param size 图片目标尺寸
 @return 规定尺寸的图片
 */
- (NSMutableArray *)imageArrayCoverToBase64ImageArrayWithTargetSize:(CGSize)size;



/**
 限制图片数组的 硬盘内存
 
 @param limitMemory 单位MB
 @return 循环压缩,一直到图片压缩到规定MB以内
 */
- (NSMutableArray *)imageArrayCoverToBase64ImageArrayLimitMemoryMB:(CGFloat)limitMemory;


/**
 指定图片尺寸，并限制总上传大小
 */
- (NSMutableArray *)imageArrayCoverToBase64ImageArrayLimitMemoryMB:(CGFloat)limitMemory targetSize:(CGSize)size;
@end
