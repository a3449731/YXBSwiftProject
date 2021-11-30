//
//  UIColor+YXBGradient.h
//  YXBSwiftProject
//
//  Created by YangXiaoBin on 2021/2/26.
//  Copyright © 2021 ShengChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ZQGradientChangeDirectionLevel, //水平方向渐变
    ZQGradientChangeDirectionVertical, //垂直方向渐变
    ZQGradientChangeDirectionUpwardDiagonalLine, //主对角线方向渐变
    ZQGradientChangeDirectionDownDiagonalLine, //副对角线方向渐变
} ZQGradientChangeDirection;

@interface UIColor (YXBGradient)

+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size direction:(ZQGradientChangeDirection)direction startColor:(UIColor*)startcolor endColor:(UIColor*)endColor;

@end

NS_ASSUME_NONNULL_END
