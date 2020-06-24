//
//  UIImage+YXBAdd.h
//  YingXingBoss
//
//  Created by 杨 on 2018/4/13.
//  Copyright © 2018年 杨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YXBAdd)


/**
 重绘 图片尺寸
 */
- (UIImage *)yxb_imageByResizeToSize:(CGSize)size;


/**
 把图片转成base64, 顺带压缩。
 
 @param compressionQuality 抗压缩性 0抗压缩 ，1最不耐抗
 @return base64
 */
- (NSString *)imageToBase64WithQuality:(CGFloat)compressionQuality;


/**
 计算图片的大小,单位 MB

 @return xxx.MB
 */
- (CGFloat)romSize;


/**
 图片压缩到指定 MB
 @return base64字符串
 */
- (NSString *)coverToBase64LinmitMB:(CGFloat)maxLength;



/**
 先转化尺寸 再压缩。 双重压缩

 @param limitMemory rom限制
 @param size 图片size, 当为CGSizeZero时，自动裁剪成屏幕大小。
 */
- (NSString *)coverToBase64LimitMemoryMB:(CGFloat)limitMemory targetSize:(CGSize)size;



-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color;
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha;
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets;
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha rect:(CGRect)rect;

/**
 *  返回圆形图片
 */
- (instancetype)yxb_circleImage;
+ (instancetype)yxb_circleImage:(NSString *)name;

@end
