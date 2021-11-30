//
//  UIView+Xib.m
//  NanNiWan
//
//  Created by wang on 2018/3/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "UIView+Xib.h"

@implementation UIView (Xib)
@dynamic  borderColor;
@dynamic borderWidth;
@dynamic cornerRadius;
/**
 *  设置边框宽度
 *
 *  @param borderWidth 可视化视图传入的值
 */
- (void)setBorderWidth:(CGFloat)borderWidth {

    if (borderWidth < 0) return;

    self.layer.borderWidth = borderWidth;
}

/**
 *  设置边框颜色
 *
 *  @param borderColor 可视化视图传入的值
 */
- (void)setBorderColor:(UIColor *)borderColor {

    self.layer.borderColor = borderColor.CGColor;
}

/**
 *  设置圆角
 *
 *  @param cornerRadius 可视化视图传入的值
 */
- (void)setCornerRadius:(CGFloat)cornerRadius {

    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}



-(void)viewWithCornerRadius:(CGFloat)cornerRadius AndBorderColor:(UIColor*)color{

    self.layer.cornerRadius=cornerRadius;
    self.layer.borderColor=color.CGColor;
    self.layer.borderWidth=1;
    self.layer.masksToBounds=YES;

}

-(void)viewWithCornerRadius:(CGFloat)cornerRadius AndBorderColor:(UIColor*)color AndborderWidth:(CGFloat)borderWidth{

    self.layer.cornerRadius=cornerRadius;
    self.layer.borderColor=color.CGColor;
    self.layer.borderWidth=borderWidth;
    self.layer.masksToBounds=YES;

}
@end
