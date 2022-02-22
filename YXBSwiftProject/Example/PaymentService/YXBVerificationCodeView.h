//
//  YXBVerificationCodeView.h
//  GJHospitalProject
//  这是个验证码输入框
//  Created by yang on 2022/1/14.
//  Copyright © 2022 GJNativeTeam. All rights reserved.
//

/*
#pragma mark --------- 验证码输入框 --------------
- (void)creatCodeView {
    YXBVCConfig *config     = [[YXBVCConfig alloc] init];
    config.inputBoxNumber  = 6;
    config.inputBoxWidth   = 44;
    config.inputBoxHeight  = 44;
    config.inputBoxSpacing = (kScreenWidth - 32 - 44 * 6) / 5; // 调整间距适配机型
    config.showFlickerAnimation = NO; // 闪动光标，还是关掉算了。
    config.tintColor       = UICOLOR_HEX(0x333333);
    config.inputBoxColor   = UICOLOR_HEX(0xCCCCCC);
    config.font            = UIPingFangRegularFontSize(20);
    config.textColor       = UICOLOR_HEX(0x333333);
    config.inputBoxBorderWidth  = 1;
    config.inputBoxCornerRadius = 4;
    config.secureTextEntry = NO;
    //config.customInputHolder = @"🔒";
    config.inputType       = GJVCConfigInputType_Number;
    config.keyboardType = UIKeyboardTypeNumberPad;

    config.inputBoxFinishColors = @[UICOLOR_HEX(0xCCCCCC), UICOLOR_HEX(0xFE6058)];
    config.finishFonts = @[UIPingFangRegularFontSize(20), UIPingFangRegularFontSize(20)];
    config.finishTextColors = @[UICOLOR_HEX(0x333333), UICOLOR_HEX(0x333333)];
    
    self.codeView = [[YXBVerificationCodeView alloc] initWithFrame:CGRectZero
                                           config:config];
    [self.view addSubview:self.codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneLabel.mas_bottom).mas_offset(30 + 30);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(44);
    }];
}
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YXBVCConfigInputType) {
    YXBVCConfigInputType_Number_Alphabet,
    YXBVCConfigInputType_Number,
    YXBVCConfigInputType_Alphabet,
};

@interface YXBVCConfig : NSObject

//============================ Initialization ============================

///输入框个数
@property (nonatomic, assign) NSInteger        inputBoxNumber;
///单个输入框的宽度
@property (nonatomic, assign) CGFloat          inputBoxWidth;
///单个输入框的高度
@property (nonatomic, assign) CGFloat          inputBoxHeight;
///单个输入框的边框宽度, Default is 1 pixel
@property (nonatomic, assign) CGFloat          inputBoxBorderWidth;
///单个输入框的边框圆角
@property (nonatomic, assign) CGFloat          inputBoxCornerRadius;
///输入框间距, Default is 5
@property (nonatomic, assign) CGFloat          inputBoxSpacing;
///左边距
@property (nonatomic, assign) CGFloat          leftMargin;
///单个输入框的颜色, Default is lightGrayColor
@property (nonatomic, strong) UIColor          *inputBoxColor;
///光标颜色, Default is blueColor
@property (nonatomic, strong) UIColor          *tintColor;
///显示 或 隐藏
@property (nonatomic, assign) BOOL             secureTextEntry;
///字体, Default is [UIFont boldSystemFontOfSize:16]
@property (nonatomic, strong) UIFont           *font;
///颜色, Default is [UIColor blackColor]
@property (nonatomic, strong) UIColor          *textColor;
///输入类型：数字+字母，数字，字母. Default is 'GJVCConfigInputType_Number_Alphabet'
@property (nonatomic, assign) YXBVCConfigInputType  inputType;
///自动弹出键盘
@property (nonatomic, assign) BOOL             autoShowKeyboard;
///默认0.5
@property (nonatomic, assign) CGFloat          autoShowKeyboardDelay;
///光标闪烁动画, Default is YES
@property (nonatomic, assign) BOOL             showFlickerAnimation;
///显示下划线
@property (nonatomic, assign) BOOL             showUnderLine;
///下划线尺寸
@property (nonatomic, assign) CGSize           underLineSize;
///下划线颜色, Default is lightGrayColor
@property (nonatomic, strong) UIColor          *underLineColor;
///自定义的输入占位字符，secureTextEntry = NO，有效
@property (nonatomic, copy) NSString         *customInputHolder;
///设置键盘类型
@property (nonatomic, assign) UIKeyboardType   keyboardType;

//============================ Input ============================

///单个输入框输入时的颜色
@property (nonatomic, strong) UIColor          *inputBoxHighlightedColor;
///下划线高亮颜色
@property (nonatomic, strong) UIColor          *underLineHighlightedColor;

//============================ Finish ============================
/* 输入完成后，可能根据不同的状态，显示不同的颜色。  */

///单个输入框输入时的颜色
@property (nonatomic, strong) NSArray<UIColor*>    *inputBoxFinishColors;
///下划线高亮颜色
@property (nonatomic, strong) NSArray<UIColor*>    *underLineFinishColors;
///输入完成时字体
@property (nonatomic, strong) NSArray<UIFont*>     *finishFonts;
///输入完成时颜色
@property (nonatomic, strong) NSArray<UIColor*>    *finishTextColors;

@end

@interface YXBVerificationCodeView : UIView

@property (nonatomic, copy) void (^inputBlock)(NSString *code);
@property (nonatomic, copy) void (^finishBlock)(YXBVerificationCodeView *codeView, NSString *code);


///输入框文本
@property (nonatomic, copy) NSString *text;

/// 初始化
/// @param frame 如果想使用闪动的光标，frame的宽度要大于2，高度要大于8
- (instancetype)initWithFrame:(CGRect)frame config:(YXBVCConfig *)config;

/**
 清空所有输入
 */
- (void)clear;

/**
 输入完成后，调用此方法，根据 index 从 `Finish` 下的4个属性获取对应的值来设置颜色。
 
 @param index 用于从 `inputBoxFinishColors`、`underLineFinishColors`、`finishFonts`、`finishTextColors`中获取对应的值
 */
- (void)showInputFinishColorWithIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
