//
//  YXBFormLabelCell.m
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/6.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "YXBFormLabelCell.h"

NSString *const YXBFormRowDescriptorTypeLabelCell = @"YXBFormRowDescriptorTypeLabelCell";

@interface YXBFormLabelCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YXBFormLabelCell

+ (void)load {
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[YXBFormLabelCell class] forKey:YXBFormRowDescriptorTypeLabelCell];
}

- (void)configure {
    [super configure];
    [self creatUI];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)creatUI {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = YXBColorBlack;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
}

- (void)update {
    [super update];
    self.titleLabel.text = self.rowDescriptor.title;
}

@end
