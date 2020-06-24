//
//  UIView+Xib.h
//  NanNiWan
//
//  Created by wang on 2018/3/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Xib)
/** 可视化设置边框宽度 */
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
/** 可视化设置边框颜色 */
@property (nonatomic, strong)IBInspectable UIColor *borderColor;

/** 可视化设置圆角 */
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;


-(void)viewWithCornerRadius:(CGFloat)cornerRadius AndBorderColor:(UIColor*)color;

-(void)viewWithCornerRadius:(CGFloat)cornerRadius AndBorderColor:(UIColor*)color AndborderWidth:(CGFloat)borderWidth;
@end
