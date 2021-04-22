//
//  PopDXCaptchaView.m
//  PKSQProject
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "PopDXCaptchaView.h"
#import <DingxiangCaptchaSDKStatic/DXCaptchaView.h>
#import <DingxiangCaptchaSDKStatic/DXCaptchaDelegate.h>
#import <DXRiskStatic/DXRiskManager.h>

@interface PopDXCaptchaView()<DXCaptchaDelegate>
@property (strong,nonatomic) DXCaptchaView *captchaView;
@end

@implementation PopDXCaptchaView
+ (PopDXCaptchaView *)createPopDXCaptchaView{
    PopDXCaptchaView * view = [[NSBundle mainBundle] loadNibNamed:@"PopDXCaptchaView" owner:nil options:nil].lastObject;
    [view setUpUI];
    [view addTapGesture];
    return view;
}
-(void)setUpUI{
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    
    NSMutableDictionary *config = [NSMutableDictionary dictionary];
    
    [config setObject:@"ae4e0aa57fb31c056fbb49a9cf72313c" forKey:@"appId"];

    CGRect frame = CGRectMake(self.center.x - scaleBase375(150) , self.center.y - scaleBase375(100), scaleBase375(300), scaleBase375(200));

    self.captchaView = [[DXCaptchaView alloc] initWithConfig:config delegate:self frame:frame];
    
    [self addSubview:self.captchaView];
}
-(void)addTapGesture{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBGView)];
    [self addGestureRecognizer:tap];
}
-(void)clickBGView{
    [self hide];
}
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)hide{
    [self removeFromSuperview];
}

- (void) captchaView:(DXCaptchaView *)view didReceiveEvent:(DXCaptchaEventType)eventType arg:(NSDictionary *)dict {
    switch(eventType) {
        case DXCaptchaEventSuccess:
        {
            [[[UIApplication sharedApplication].keyWindow viewWithTag:1234] removeFromSuperview];
            NSString *token = dict[@"token"];
            if(self.PopDXCaptchaViewSuccess){
                self.PopDXCaptchaViewSuccess(token);
                [self hide];
            }
            break;
        }
        case DXCaptchaEventFail:
            ShowToast(@"验证失败") 
            break;
        default:
            break;
    }
}


@end


