//
//  NSLayoutConstraint+AutoScale.h
//  SmartCity
//
//  Created by ZCGC on 2017/8/22.
//  Copyright © 2017年 NRH. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN CGFloat screenWidthScaleBase375(void);

@interface NSLayoutConstraint (AutoScale)
/**
 是否自动根据375屏幕宽度进行缩放constant的值.
 */
@property (nonatomic, assign) IBInspectable BOOL autoScale;
@end
