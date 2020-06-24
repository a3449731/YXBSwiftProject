//
//  YXBImageCell.m
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/12.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "YXBImageCell.h"

@implementation YXBImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

@end
