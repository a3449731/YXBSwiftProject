//
//  YXBReusableView.m
//  YunXiaoZhi
//
//  Created by YangXiaoBin on 2019/11/1.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "YXBHeaderView.h"

@implementation YXBHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.leftButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [self.bgView addSubview:self.leftButton];
    [self.leftButton addTarget:self action:@selector(tapLeftAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.rightButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [self.bgView addSubview:self.rightButton];
    [self.rightButton addTarget:self action:@selector(tapRightAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.imageView = [[UIImageView alloc] init];
    [self.bgView addSubview:self.imageView];
}

- (void)tapLeftAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(reusableView:tapLeftButton:)]) {
        [self.delegate reusableView:self tapLeftButton:button];
    }
}

- (void)tapRightAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(reusableView:tapRightButton:)]) {
        [self.delegate reusableView:self tapRightButton:button];
    }
}


@end
