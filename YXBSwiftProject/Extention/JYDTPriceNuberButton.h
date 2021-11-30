//
//  JYDTPriceNuberButton.h
//  NIM
//
//  Created by YangXiaoBin on 2020/6/5.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "PPNumberButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPNumberButton () <UITextFieldDelegate>
{
    @public CGFloat _width;     // 控件自身的宽
    @public CGFloat _height;    // 控件自身的高
}

/** 减按钮*/
@property (nonatomic, strong) UIButton *decreaseBtn;
/** 加按钮*/
@property (nonatomic, strong) UIButton *increaseBtn;
/** 数量展示/输入框*/
@property (nonatomic, strong) UITextField *textField;

@end

@interface JYDTPriceNuberButton : PPNumberButton

@end

NS_ASSUME_NONNULL_END
