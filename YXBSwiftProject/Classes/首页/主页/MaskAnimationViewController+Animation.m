//
//  MaskAnimationViewController+Animation.m
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/13.
//  Copyright © 2023 ShengChang. All rights reserved.
//

#import "MaskAnimationViewController+Animation.h"
#import "LJKAudioCallAssistiveTouchView.h"
#import "LQCircleMaskAnimation.h"

@interface MaskAnimationViewController () <LJKAudioCallAssistiveTouchViewDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) CAShapeLayer *maskLayer;
@property (strong, nonatomic) LJKAudioCallAssistiveTouchView *touchView;

@end

@implementation MaskAnimationViewController (Animation)

// MARK: viewWillAppear时调用
- (void)hideAudioCallAssistiveTouchView {
    self.navigationController.delegate = self;
    if (self.touchView) {
        [self.touchView removeFromSuperview];
        self.touchView = nil;
    }
}


// MARK: viewWillDisappear时调用
- (void)showAudioCallAssistiveTouchView {
    self.navigationController.delegate = nil;
    if (!self.touchView) {
        self.touchView = [[LJKAudioCallAssistiveTouchView alloc] initDefaultType];
//        [self.touchView.imageView sd_setImageWithURL: placeholderImage:nil];
        self.touchView.nameLabel.text = @"房间名";
        self.touchView.delegate = self;
        [[LJKAudioCallAssistiveTouchView getCurrentWindow] addSubview:self.touchView];
    } else {
        [self.touchView setHidden:NO];
    }
}


// 最小化
- (void)smallButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self addBecomeSmallAnimation];
}

#pragma mark ---- LJKAudioCallAssistiveTouchViewDelegate ----
// 点击了浮窗
- (void)assistiveTouchViewClicked {
    MaskAnimationViewController *vc = [MaskAnimationViewController sharedManager];
    vc.hidesBottomBarWhenPushed = YES;
    NSLog(@"[ScreenConst getCurrentUIController] %@", [ScreenConst getCurrentUIController]);
    [[ScreenConst getCurrentUIController].navigationController pushViewController:vc animated:YES];

//    [self addBecomeBigAnimation];
    
}

// 点击了浮窗里的关闭
- (void)closeClicked {
    
}


#pragma mark ---- UINavigationControllerDelegate ----
// 转场动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([fromVC isEqual:[MaskAnimationViewController sharedManager]] && operation == UINavigationControllerOperationPop) {
        return [[LQCircleMaskAnimation alloc]init];
    } else {
        return nil;
    }
}

@end
