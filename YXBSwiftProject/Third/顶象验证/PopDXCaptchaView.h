//
//  PopDXCaptchaView.h
//  PKSQProject
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopDXCaptchaView : UIView
@property (copy, nonatomic) void(^PopDXCaptchaViewSuccess)(NSString * token);
@property (copy, nonatomic) void(^PopDXCaptchaViewFailure)(BOOL failure);

+ (PopDXCaptchaView *)createPopDXCaptchaView;
-(void)show ;
-(void)hide;
@end

NS_ASSUME_NONNULL_END
