//
//  MBProgressHUD+NH.h
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/13.
//  Copyright © 2023 ShengChang. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (NH)

+ (MBProgressHUD *)createHUD:(NSString *)loadTitle;

+ (void)showHUDWithTextAutoHidden:(NSString*)text;

+(void)showHUDWithText_loding_AutoHidden;

/**
 提示文字 显示在指定视图上
 
 @param notice 提示信息
 @param view 视图
 */
+ (void)showNotice:(NSString *)notice toView:(UIView *)view;
+ (void)showNotice:(NSString *)notice;
+ (void)hideHUD;
+ (void)showUntimedWithString:(NSString *)string;

+ (void)showUntimedWithString:(NSString *)string toView:(UIView *)view;
+ (void)showProgressToView:(UIView *)view;

+ (void)showKeybordHidden:(NSString*)text;

+(void)HUDScuessWithTip:(NSString*)tip;


// 加载gif动图
+ (void)showGifToView:(UIView * _Nullable)view;
+ (void)showGifToView:(UIView * _Nullable)view  gifName:(NSString *)gifName;

// 隐藏gif动画
+ (void)hideGifHUD;
+ (void)hideGifHUDForView:(UIView * _Nullable)view;

+ (void)showCustomTipTitle:(NSString *  _Nullable)title titleColr:(UIColor *)color imageNamed:(NSString * _Nullable)imageNamed content:(NSString *  _Nullable)content;

@end

NS_ASSUME_NONNULL_END
