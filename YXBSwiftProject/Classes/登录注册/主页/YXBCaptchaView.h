//
//  YXBCaptchaView.h
//  YXBSwiftProject
//
//  Created by YangXiaoBin on 2020/6/30.
//  Copyright © 2020 ShengChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXBCaptchaView : UIView

@property (nonatomic, strong)NSArray *CatArray;//验证码素材库

@property (nonatomic, strong)NSMutableString *CatString;//验证码字符串

@end

NS_ASSUME_NONNULL_END
