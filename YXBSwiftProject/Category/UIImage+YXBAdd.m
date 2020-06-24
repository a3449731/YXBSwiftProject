//
//  UIImage+YXBAdd.m
//  YingXingBoss
//
//  Created by 杨 on 2018/4/13.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "UIImage+YXBAdd.h"

@implementation UIImage (YXBAdd)

- (UIImage *)yxb_imageByResizeToSize:(CGSize)size
{
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSString *)imageToBase64WithQuality:(CGFloat)compressionQuality
{
    return [UIImageJPEGRepresentation(self, compressionQuality) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (CGFloat)romSize
{
    CGFloat cgImageBytesPerRow = CGImageGetBytesPerRow(self.CGImage); // 2560
    CGFloat cgImageHeight = CGImageGetHeight(self.CGImage); // 1137
    CGFloat size  = cgImageHeight * cgImageBytesPerRow / 1024.f / 1024.f;
    return size;
}


- (NSString *)coverToBase64LinmitMB:(CGFloat)maxLength
{
    
    maxLength = maxLength * 1024 * 1024; // 换算成 字节
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length  < maxLength)
    {
        return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length  < maxLength * 0.9) {
            min = compression;
        } else if (data.length  > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}


// base64字符串。
- (NSString *)coverToBase64LimitMemoryMB:(CGFloat)limitMemory targetSize:(CGSize)size
{
    CGFloat newWidth = size.width;
    CGFloat newHegiht = size.height;
    if (!size.width || !size.height) // 没有指定宽高
    {
        newWidth = self.size.width > kScreenWidth ? kScreenWidth : self.size.width;
        newHegiht = newWidth * self.size.height / self.size.width;
    }
    
    UIImage *yxbImage = [self yxb_imageByResizeToSize:CGSizeMake(newWidth, newHegiht)];
    NSString *base64String = [yxbImage coverToBase64LinmitMB:limitMemory];
    
    return base64String;
}

-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color
{
    return [self wr_updateImageWithTintColor:color alpha:1.0f];
}
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha
{
    CGRect rect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    return [self wr_updateImageWithTintColor:color alpha:alpha rect:rect];
}
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color rect:(CGRect)rect
{
    return [self wr_updateImageWithTintColor:color alpha:1.0f rect:rect];
}
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color insets:(UIEdgeInsets)insets
{
    return [self wr_updateImageWithTintColor:color alpha:1.0f insets:insets];
}
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets
{
    CGRect originRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    CGRect tintImageRect = UIEdgeInsetsInsetRect(originRect, insets);
    return [self wr_updateImageWithTintColor:color alpha:alpha rect:tintImageRect];
}

#pragma mark - 全能初始化方法
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha rect:(CGRect)rect
{
    CGRect imageRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    
    // 启动图形上下文
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    // 获取图片上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    // 利用drawInRect方法绘制图片到layer, 是通过拉伸原有图片
    [self drawInRect:imageRect];
    // 设置图形上下文的填充颜色
    CGContextSetFillColorWithColor(contextRef, [color CGColor]);
    // 设置图形上下文的透明度
    CGContextSetAlpha(contextRef, alpha);
    // 设置混合模式
    CGContextSetBlendMode(contextRef, kCGBlendModeSourceAtop);
    // 填充当前rect
    CGContextFillRect(contextRef, rect);
    
    // 根据位图上下文创建一个CGImage图片，并转换成UIImage
    CGImageRef imageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *tintedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    // 释放 imageRef，否则内存泄漏
    CGImageRelease(imageRef);
    // 从堆栈的顶部移除图形上下文
    UIGraphicsEndImageContext();
    
    return tintedImage;
}


- (instancetype)yxb_circleImage{
    
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    // 绘制图片
    [self drawInRect:rect];
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)yxb_circleImage:(NSString *)name{
    
    return [[self imageNamed:name] yxb_circleImage];
}


@end
