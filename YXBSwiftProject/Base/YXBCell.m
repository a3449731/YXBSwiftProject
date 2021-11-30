//
//  YXBCell.m
//  MyProject
//
//  Created by YangXiaoBin on 2019/11/15.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "YXBCell.h"

@interface YXBCell ()

@property (nonatomic, strong) UIView *lineView;

@end


@implementation YXBCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _lineView = [[UIView alloc] init];
        _lineView.frame = CGRectMake(0, frame.size.height - 1, frame.size.width, 1);
        [self.contentView addSubview:_lineView];
        // 默认值
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
        self.separatorColor = YXBColor_separator;
    }
    return self;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    _lineView.backgroundColor = separatorColor;
}

- (void)setSeparatorInset:(UIEdgeInsets)separatorInset {
    _separatorInset = separatorInset;
    _lineView.qmui_left = separatorInset.left;
    _lineView.qmui_width = self.qmui_width - separatorInset.right - separatorInset.left;
    _lineView.qmui_bottom = self.qmui_height - separatorInset.bottom - separatorInset.top - _lineView.qmui_height;
}

- (void)setSeparatorStyle:(UITableViewCellSeparatorStyle)separatorStyle {
    _separatorStyle = separatorStyle;
    if (separatorStyle == UITableViewCellSeparatorStyleSingleLine || separatorStyle == UITableViewCellSeparatorStyleSingleLineEtched) {
        _lineView.hidden = NO;
    } else {
        _lineView.hidden = YES;
    }
}

- (void)layoutSubviews {
    [self bringSubviewToFront:self.lineView];
    [super layoutSubviews];
}

- (void)cellForModel:(id)model {
    
}

@end
