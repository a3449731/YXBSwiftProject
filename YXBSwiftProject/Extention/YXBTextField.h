//
//  YXBTextField.h
//  YingXingBoss
//
//  Created by 杨 on 2018/3/26.
//  Copyright © 2018年 杨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXBTextField : UITextField


/**
 leftView的Frame
 */
@property (nonatomic , assign) CGRect  leftViewFrame;
@property (nonatomic , strong) UIButton *leftButton;
@property (nonatomic , copy) NSString *leftText;
@property (nonatomic , strong) UIColor *leftTextColor;
@property (nonatomic , strong) UIFont *leftTextFont;
@property (nonatomic , strong) UIImage *leftImage;


@property (nonatomic , assign) CGRect  rightViewFrame;
@property (nonatomic , strong) UIButton *rightButton;
@property (nonatomic , copy) NSString *rightText;
@property (nonatomic , strong) UIColor *rightTextColor;
@property (nonatomic , strong) UIFont *rightTextFont;
@property (nonatomic , strong) UIImage *rightImage;

/**
 下划线的颜色
 */
@property (nonatomic , strong) UIColor *lineColor;



/**只有在设置了placeholder之后才会有效**/
@property (nonatomic , strong) UIColor *placeholderColor;
@property (nonatomic , strong) UIFont *placeholderFont;



/**
 图形验证码， 暂只支持 右边button。
 赋值请使用 refreshImageWithString。
 */
@property (nonatomic , copy , readonly) NSString *imageCodeString;
- (void)refreshImageWithString:(NSString *)codeString;

/**
 图形验证码的背景色
 
 */

@property (nonatomic , strong) UIColor *                                                                          codeBackgroundColor;

@end

