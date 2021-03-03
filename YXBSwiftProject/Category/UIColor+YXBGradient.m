//
//  UIColor+YXBGradient.m
//  YXBSwiftProject
//
//  Created by YangXiaoBin on 2021/2/26.
//  Copyright © 2021 ShengChang. All rights reserved.
//

#import "UIColor+YXBGradient.h"

@implementation UIColor (YXBGradient)

+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size direction:(ZQGradientChangeDirection)direction startColor:(UIColor*)startcolor endColor:(UIColor*)endColor {
    if (CGSizeEqualToSize(size, CGSizeZero) || !startcolor || !endColor) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    CGPoint startPoint = CGPointZero;
    if (direction == ZQGradientChangeDirectionDownDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    gradientLayer.startPoint = startPoint;
    
    CGPoint endPoint = CGPointZero;
    switch (direction) {
        case ZQGradientChangeDirectionLevel:
            endPoint = CGPointMake(1.0, 0.0);
            break;
            
        case ZQGradientChangeDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
            
        case ZQGradientChangeDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
            
        case ZQGradientChangeDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);
            break;
            
        default:
            break;
    }
    gradientLayer.endPoint = endPoint;
    gradientLayer.colors = @[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
    
}

@end
