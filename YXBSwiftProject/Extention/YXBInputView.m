//
//  YXBInputView.m
//  NIM
//
//  Created by YangXiaoBin on 2020/7/17.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "YXBInputView.h"

@interface YXBInputView () <QMUITextFieldDelegate>

@end

@implementation YXBInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame inputSendText:(void(^)(QMUITextField *textField, QMUIButton *sendButton))sendText {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
        // 持有block
        self.sendTextBlock = sendText;
    }
    return self;
}

- (void)creatUI {
    self.backgroundColor = YXBColor_background;
    self.layer.borderColor = YXBColor_separator_highLight.CGColor;
    self.layer.borderWidth = 0.5;
    
    self.inputTextField = [[QMUITextField alloc] init];
    self.inputTextField.delegate = self;
    self.inputTextField.backgroundColor = YXBColor_background_light;
    self.inputTextField.layer.borderColor = YXBColor_separator_highLight.CGColor;
    self.inputTextField.layer.borderWidth = 0.5;
    self.inputTextField.layer.cornerRadius = 4;
    self.inputTextField.placeholderColor = YXBColor_placeholder;
    self.inputTextField.textColor = YXBColor_titleText;
    self.inputTextField.textInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    self.inputTextField.placeholder = @"写评论";
    self.inputTextField.returnKeyType = UIReturnKeySend;
    self.inputTextField.enablesReturnKeyAutomatically = YES;
    [self addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-100);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    
    self.sendButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    self.sendButton.backgroundColor = YXBColor_descriptionText;
    self.sendButton.layer.cornerRadius = 4;
    self.sendButton.layer.masksToBounds = YES;
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.sendButton setTitleColor:YXBColor_descriptionText_highLight forState:(UIControlStateNormal)];
    [self.sendButton setTitle:@"发送" forState:(UIControlStateNormal)];
    [self addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.inputTextField.mas_right).mas_offset(15);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    [self.sendButton addTarget:self action:@selector(sendAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)sendAction:(UIButton *)button {
    if (self.sendTextBlock) {
        self.sendTextBlock(self.inputTextField, self.sendButton);
    }
}

- (void)show {
    CGRect frame = CGRectMake(0, kScreenHeight - self.qmui_height, self.qmui_width, self.qmui_height);
    QMUIModalPresentationViewController *modalVC = [QMUIModalPresentationViewController new];
    modalVC.contentView = self;
    modalVC.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
        self.qmui_frameApplyTransform = frame;
    };
    [modalVC showWithAnimated:true completion:nil];
    [self.inputTextField becomeFirstResponder];
}

- (void)dismiss {
    self.sendTextBlock = nil;
    [self.inputTextField resignFirstResponder];
    [(QMUIModalPresentationViewController *)self.qmui_viewController hideWithAnimated:YES completion:nil];
}

#pragma mark --------- 键盘按钮的监听 -------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sendAction:nil];
    return YES;
}

- (void)dealloc {
    self.sendTextBlock = nil;
}

@end
