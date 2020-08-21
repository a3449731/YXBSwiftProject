//
//  YXBInputView.h
//  NIM
//
//  Created by YangXiaoBin on 2020/7/17.
//  Copyright © 2020 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXBInputView : UIView

@property (nonatomic, strong) QMUITextField *inputTextField;
@property (nonatomic, strong) QMUIButton *sendButton;
@property (nonatomic, copy, nullable) void(^sendTextBlock)(QMUITextField *textField, QMUIButton *sendButton);

- (instancetype)initWithFrame:(CGRect)frame inputSendText:(void(^)(QMUITextField *textField, QMUIButton *sendButton))sendText;

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
