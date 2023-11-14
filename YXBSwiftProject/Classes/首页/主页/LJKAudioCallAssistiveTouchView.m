//
//  LJKAudioCallAssistiveTouchView.m
//  CUYuYinFang
//
//  Created by 芦 on 2023/8/3.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

#import "LJKAudioCallAssistiveTouchView.h"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define defaultHeight 55
#define defaultWidth 130
#define leftAndRightSpace 10

@interface LJKAudioCallAssistiveTouchView ()

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation LJKAudioCallAssistiveTouchView

- (void)removeFromSuperview{
    [super removeFromSuperview];
}

- (instancetype)initDefaultType{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(kScreenWidth - leftAndRightSpace - defaultWidth, kScreenHeight - 190, defaultWidth, defaultHeight);
//        self.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.06].CGColor;
//        self.layer.shadowOffset = CGSizeMake(0,2);
//        self.layer.shadowOpacity = 0.8;
//        self.layer.shadowRadius = 5;
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, defaultWidth, defaultHeight)];
        backView.backgroundColor = [UIColor systemPinkColor];
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius  = defaultHeight/2;
        [self addSubview:backView];
        
        _imageView = [[UIImageView alloc]initWithFrame:(CGRect){8, 10, 35, 35}];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius  = 35/2;
        _imageView.image = [UIImage imageNamed:@"CUYuYinFang_login_logo"];
        [backView addSubview:_imageView];
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 4;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = HUGE_VALF;
        [_imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 11, 40, 14)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [_nameLabel setTextColor:[UIColor whiteColor]];
        _nameLabel.text = @"";
        [backView addSubview:_nameLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 32, 50, 12)];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont systemFontOfSize:10]];
        [_timeLabel setTextColor:[UIColor whiteColor]];
        _timeLabel.text = @"回到房间";
        [backView addSubview:_timeLabel];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(locationChange:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(100-5,12, 30, 30);
        [closeBtn setImage:[UIImage imageNamed:@"CUYuYinFang_zhibojian_guanbi"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
    }
    return self;
}

- (void)closeBtnClick
{
    if ([self.delegate respondsToSelector:@selector(closeClicked)]) {
        [self.delegate closeClicked];
    }
//    [self removeFromSuperview];
}

//改变位置
- (void)locationChange:(UIPanGestureRecognizer*)p
{

    CGPoint panPoint = [p locationInView:[LJKAudioCallAssistiveTouchView getCurrentWindow]];

    if(p.state == UIGestureRecognizerStateChanged)
    {
        self.center = CGPointMake(panPoint.x, panPoint.y);
    }
    else if(p.state == UIGestureRecognizerStateEnded)
    {
        CGFloat iPhoneTopMargin = [LJKAudioCallAssistiveTouchView iPhoneTopMargin];
        
        CGFloat iPhoneBottomMargin = [LJKAudioCallAssistiveTouchView iPhoneBottomMargin];
        
        if(panPoint.x <= kScreenWidth / 2)
        {
            if(panPoint.y < iPhoneTopMargin + HEIGHT / 2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(WIDTH / 2 + leftAndRightSpace, iPhoneTopMargin + HEIGHT / 2);
                }];
            }
            else if(panPoint.y >= kScreenHeight - HEIGHT / 2 - iPhoneBottomMargin)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(WIDTH / 2 + leftAndRightSpace, kScreenHeight - HEIGHT / 2 - iPhoneBottomMargin);
                }];
            }
            else
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(WIDTH / 2 + leftAndRightSpace, panPoint.y);
                }];
            }
        }
        else if(panPoint.x > kScreenWidth / 2)
        {
            if(panPoint.y <= iPhoneTopMargin + HEIGHT / 2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(kScreenWidth - WIDTH / 2 - leftAndRightSpace, iPhoneTopMargin + HEIGHT / 2);
                }];
            }
            else if(panPoint.y > kScreenHeight - HEIGHT / 2 - iPhoneBottomMargin)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(kScreenWidth - WIDTH / 2 - leftAndRightSpace, kScreenHeight - HEIGHT / 2 - iPhoneBottomMargin);
                }];
            }
            else
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(kScreenWidth - WIDTH / 2 - leftAndRightSpace, panPoint.y);
                }];
            }
        }
    }

}
//点击事件
-(void)click:(UITapGestureRecognizer*)t
{
    
    if ([self.delegate respondsToSelector:@selector(assistiveTouchViewClicked)]) {
        [self.delegate assistiveTouchViewClicked];
    }
}

+ (CGFloat)iPhoneTopMargin {
    if (@available(iOS 11.0, *)) {
        return [self getCurrentWindow].safeAreaInsets.top;
    } else {
        return 20;
    }
}

+ (CGFloat)iPhoneBottomMargin {
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    } else {
        return 0;
    }
}

+ (UIWindow *)getCurrentWindow {
    __block UIWindow * window;
    
    if (@available(iOS 13.0, *)) {
        
        [[UIApplication sharedApplication].connectedScenes enumerateObjectsUsingBlock:^(UIScene * _Nonnull obj, BOOL * _Nonnull stop) {
            if (obj.activationState == UISceneActivationStateForegroundActive &&
                [obj isKindOfClass:UIWindowScene.self]) {
                UIWindowScene * windowScene = (UIWindowScene *)obj;
                NSArray<UIWindow *> * windows = windowScene.windows;
                for (UIWindow * win in windows) {
                    if ([win isKeyWindow]) {
                        window = win;
                        *stop = true;
                        break;
                    }
                }
            }
        }];
        
        if (window == nil) {
            NSArray<UIWindow *> * windows = [[UIApplication sharedApplication]windows];
            for (UIWindow * win in windows) {
                if ([win isKeyWindow]) {
                    window = win;
                    break;
                }
            }
        }
        
    }else{
        window = [[UIApplication sharedApplication]keyWindow];
    }
    
    return window;
}

@end
