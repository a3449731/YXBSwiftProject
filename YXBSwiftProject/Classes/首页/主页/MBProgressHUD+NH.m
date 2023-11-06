//
//  MBProgressHUD+NH.m
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/13.
//  Copyright © 2023 ShengChang. All rights reserved.
//

#import "MBProgressHUD+NH.h"
#import <SDWebImage.h>

@implementation MBProgressHUD (NH)

+ (MBProgressHUD *)createHUD:(NSString *)loadTitle {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];

    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:20];
    
    [window addSubview:HUD];
    
    [HUD show:YES];
    
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = loadTitle?loadTitle:@"努力加载中......";
    HUD.margin = 10.f;

//    HUD.color=colorTheme;

//    HUD.color=RGBA(92, 92, 92,1);
    [HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    
    return HUD;
}

+(void)hide:(MBProgressHUD*)hud{
    [hud hide:YES];
}

+ (void)showHUDWithTextAutoHidden:(NSString*)text {
    MBProgressHUD *HUD = [self createHUD:nil];
    // Configure for text only and offset down
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = text;
    HUD.margin = 10.f;
    [HUD hide:YES afterDelay:2];
}

+ (void)showHUDWithText_loding_AutoHidden{
    [self showHUDWithTextAutoHidden:@"加载中..."];
}


+ (void)HUDError{
    MBProgressHUD *HUD = [self createHUD:nil];
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD_Error"]];
    HUD.labelText = @"网络异常，发送失败";
    [HUD hide:YES afterDelay:1.0];
}

/**
 *  只显示文字  (限时)
 *
 *  @param notice 要显示的文字
 */
+ (void)showNotice:(NSString *)notice{
    [self showNotice:notice toView:nil];
}
/**
 提示文字 显示在指定视图上
 
 @param notice 提示信息
 @param view 视图
 */
+ (void)showNotice:(NSString *)notice toView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = notice;
    
    // 设置图片
    //    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    //    hud.color = colorTheme;
//    hud.detailsLabelFont = [UIFont systemFontOfSize:autoScale(30)];
//    hud.margin = autoScale(10);
    hud.margin = 10;
    // 0.9秒之后再消失
    [hud hide:YES afterDelay:0.9];
    
}
+ (void)showUntimedWithString:(NSString *)string{
    
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //    hud.mode = MBProgressHUDModeCustomView;
    //    hud.labelText = string;
    [self showUntimedWithString:string toView:nil];
}

+ (void)showUntimedWithString:(NSString *)string toView:(UIView *)view{
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = string;
    
    // 设置图片
    //    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 0.9秒之后再消失
    //    [hud hide:YES afterDelay:0.9];
    
}
+ (void)hideHUD
{
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
    //    [self hideHUDForView:view];
    
}
+ (void)showProgressToView:(UIView *)view{
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.mode = MBProgressHUDModeIndeterminate;
    hub.animationType = MBProgressHUDAnimationFade;
    //    hub.color = colorTheme;
//    hub.margin = autoScale(10);
    hub.margin = 10;
}

+ (void)showKeybordHidden:(NSString*)text{
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    // Configure for text only and offset down
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = NSLocalizedString(text, @"HUD message title");
    HUD.label.font = [UIFont systemFontOfSize:16];
    HUD.offset = CGPointMake(0, -100);
    HUD.margin = 10.f;
    [HUD hideAnimated:NO afterDelay:1];
}


+(void)HUDScuessWithTip:(NSString*)tip{
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
     MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
     HUD.mode = MBProgressHUDModeCustomView;
     UIImage *image = [UIImage imageNamed:@"提示框成功"];
     HUD.customView = [[UIImageView alloc] initWithImage:image];
     HUD.label.text = tip;
     [HUD hideAnimated:NO afterDelay:1.5f];
}


+ (void)showGifToView:(UIView * _Nullable)view {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self showGifToView:view gifName:@"loadinging"];
}

+ (void)showGifToView:(UIView *)view gifName:(NSString *)gifName {
    //这里最好加个判断，让这个加载动画添加到window上，调用的时候，这个view传个nil就行了！
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:gifName withExtension:@"gif"];
    //自定义imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView sd_setImageWithURL:url];
    
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor clearColor];
    [myView addSubview:imageView];
    // 在这控制的gif大小，必须得包一层
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.height.mas_equalTo(50);
    }];
    
    //设置hud模式
    hud.mode = MBProgressHUDModeCustomView;
    
    //设置在hud影藏时将其从SuperView上移除,自定义情况下默认为NO
    hud.removeFromSuperViewOnHide = YES;
    
    /*
    //设置提示性文字
    hud.label.text = @"正在加载中";
    
    // 设置文字大小
    hud.label.font = [UIFont systemFontOfSize:20];
    
    //设置文字的背景颜色
    hud.label.backgroundColor = [UIColor redColor];
    */
        
    //设置方框view为该模式后修改颜色才有效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    //设置方框view背景色
    hud.bezelView.backgroundColor = [UIColor clearColor];
    
    //设置总背景view的背景色，并带有透明效果
//    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    hud.customView = myView;
    
    // 设置这个可以让其穿透，响应底下的按钮
    // * @note To still allow touches to pass through the HUD, you can set hud.userInteractionEnabled = NO.
    // * @attention MBProgressHUD is a UI class and should therefore only be accessed on the main thread.
//    hud.userInteractionEnabled = NO;
    
    // 加一个点击消失的点击事件, 这样加手势会有问题，不能加
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGifBackGround:)];
//    [view addGestureRecognizer:tap];
}

//+ (void)tapGifBackGround:(UITapGestureRecognizer *)tap {
//    [self hideGifHUDForView:tap.view];
//}

//隐藏加载动画的方法
+ (void)hideGifHUDForView:(UIView *)view {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideGifHUD {
    [self hideGifHUDForView:nil];
}

+ (void)showCustomTipTitle:(NSString *)title titleColr:(UIColor *)color imageNamed:(NSString *)imageNamed content:(NSString *)content {
    //这里最好加个判断，让这个加载动画添加到window上，调用的时候，这个view传个nil就行了！
    UIView *view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageNamed];
    [myView addSubview:imageView];
    
//    UILabel *titleLabel = [[[my commonLabelWithFrame:CGRectZero text:title color:color font:[UIFont boldSystemFontOfSize:16] lines:1 textAlignment:(NSTextAlignmentCenter)]]];
    UILabel *titleLabel = [[UILabel alloc] init];
    [myView addSubview:titleLabel];
        
//    UILabel *contentLabel = [MyTool commonLabelWithFrame:CGRectZero text:content color:rgba(51, 51, 51, 1) font:[UIFont boldSystemFontOfSize:12] lines:0 textAlignment:(NSTextAlignmentCenter)];
    UILabel *contentLabel = [[UILabel alloc] init];
    [myView addSubview:contentLabel];
    
    UIButton *closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [closeButton setImage:[UIImage imageNamed:@"rank_tip_close"] forState:(UIControlStateNormal)];
    [myView addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
    }];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-20);
        make.width.height.mas_equalTo(32);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-30);
    }];
    
    //设置hud模式
    hud.mode = MBProgressHUDModeCustomView;
    
    //设置在hud影藏时将其从SuperView上移除,自定义情况下默认为NO
    hud.removeFromSuperViewOnHide = YES;
    
    /*
    //设置提示性文字
    hud.label.text = @"正在加载中";
    
    // 设置文字大小
    hud.label.font = [UIFont systemFontOfSize:20];
    
    //设置文字的背景颜色
    hud.label.backgroundColor = [UIColor redColor];
    */
        
    //设置方框view为该模式后修改颜色才有效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    //设置方框view背景色
    hud.bezelView.backgroundColor = [UIColor clearColor];
    
    //设置总背景view的背景色，并带有透明效果
//    hud.backgroundColor = rgba(0, 0, 0, 0.5);
    hud.customView = myView;
    
    // 设置这个可以让其穿透，响应底下的按钮
    // * @note To still allow touches to pass through the HUD, you can set hud.userInteractionEnabled = NO.
    // * @attention MBProgressHUD is a UI class and should therefore only be accessed on the main thread.
//    hud.userInteractionEnabled = NO;
    
    // 加一个点击消失的点击事件, 这样加手势会有问题，不能加
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGifBackGround:)];
//    [view addGestureRecognizer:tap];
}

+ (void)closeButtonAction {
    UIView *view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:YES];
}

@end
