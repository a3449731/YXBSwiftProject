//
//  CircleAnimation.m
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/14.
//  Copyright © 2023 ShengChang. All rights reserved.
//

#import "LQCircleMaskAnimation.h"
#import "MaskAnimationViewController.h"

@interface LQCircleMaskAnimation () <CAAnimationDelegate>

@property (assign, nonatomic) id <UIViewControllerContextTransitioning> context;

@end

@implementation LQCircleMaskAnimation

// 动画时间
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.28;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    // 这是为了禁用UITabBar的隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    // 在动画结束时调用 [CATransaction commit]
    
    //得到上下文
    self.context = transitionContext;
    //获取容器视图
    UIView *container = [transitionContext containerView];
    //获取参与转场的viewcontroller
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
                
    if ([toVC isEqual:[MaskAnimationViewController sharedManager]]) {
        [container addSubview:toVC.view];
        [self addBecomeBigAnimation:toVC.view];
    } else if ([fromVC isEqual:[MaskAnimationViewController sharedManager]]) {
        [container addSubview:toVC.view];
        [container addSubview:fromVC.view];
        [self addBecomeSmallAnimation:fromVC.view];
    }
    
    // 隐藏导航栏，避免在动画中不协调
    BOOL shouldHideBottomBar = [toVC isKindOfClass:[MaskAnimationViewController class]];
    if (shouldHideBottomBar) {
        fromVC.tabBarController.tabBar.hidden = YES;
    }
}

- (void)addBecomeSmallAnimation:(UIView *)toVCView {
//    CGRect endFrame = self.btn.frame;
    CGRect endFrame = CGRectMake(150, 150, 150, 50);
    // 进行坐标系转换
    NSLog(@"结束坐标%@", NSStringFromCGRect(endFrame));
    
    // 用对角线做圆的半径。勾股定理
    CGFloat width = (SCREEN_WIDTH - endFrame.size.width / 2);
    CGFloat height = (SCREEN_HEIGHT - endFrame.size.height / 2);
    CGFloat radius = sqrt(pow(width, 2) + pow(height, 2));
    CGRect startFrame = CGRectInset(endFrame, -radius, -radius);
    NSLog(@"起始坐标%@", NSStringFromCGRect(startFrame));
    
    //创建动画
    CABasicAnimation *maskLayerAnimation = [self creatMaskAnimation:@"path" startFrame:startFrame endFrame:endFrame duration:0.28];
    maskLayerAnimation.delegate = self;
    
    //添加动画遮罩
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    [shapeLayer addAnimation:maskLayerAnimation forKey:@"path"];
    toVCView.layer.mask = shapeLayer;
}

// 添加由小变大的动画
- (void)addBecomeBigAnimation:(UIView *)toVCView {
        
//    CGRect startFrame = self.touchView.frame;
    // 进行坐标系转换
//    startFrame = [self.touchView.superview convertRect:startFrame toView:self.view];
    CGRect startFrame = CGRectMake(235, 622, 130, 55);
    NSLog(@"起始坐标%@", NSStringFromCGRect(startFrame));
    
    // 用屏幕对角线做圆的半径。勾股定理
    CGFloat width = (SCREEN_WIDTH - startFrame.size.width / 2);
    CGFloat height = (SCREEN_HEIGHT - startFrame.size.height / 2);
    CGFloat radius = sqrt(pow(width, 2) + pow(height, 2));
    CGRect endFrame = CGRectInset(startFrame, -radius, -radius);
    NSLog(@"结束坐标%@", NSStringFromCGRect(endFrame));
    
    //创建动画
    CABasicAnimation *maskLayerAnimation = [self creatMaskAnimation:@"path" startFrame:startFrame endFrame:endFrame duration:0.28];
    maskLayerAnimation.delegate = self;
    
    //添加动画遮罩
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    [shapeLayer addAnimation:maskLayerAnimation forKey:@"path"];
    toVCView.layer.mask = shapeLayer;
}

// 创建path动画
- (CABasicAnimation *)creatMaskAnimation:(NSString *)keyPath startFrame:(CGRect)startFrame endFrame:(CGRect)endFrame duration:(CFTimeInterval)duration {
    //起始圆
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRoundedRect:startFrame cornerRadius:startFrame.size.width / 2];
    // 终止圆
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:endFrame cornerRadius:endFrame.size.width / 2];
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    maskLayerAnimation.fromValue = (__bridge id)([startPath CGPath]);
    maskLayerAnimation.toValue = (__bridge id)([endPath CGPath]);
    maskLayerAnimation.duration = duration;
    // 动画结束停留在最后一帧
    maskLayerAnimation.fillMode = kCAFillModeForwards;
    maskLayerAnimation.removedOnCompletion = NO;
    
    return maskLayerAnimation;
}

#pragma mark ---- CAAnimationDelegate ----
/* Called when the animation begins its active duration. */
- (void)animationDidStart:(CAAnimation *)anim {
    
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.context viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    [self.context viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.context completeTransition:![self.context transitionWasCancelled]];
    
    [CATransaction commit];
}

@end
