//
//  YXBCell.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/11/15.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXBCell : UICollectionViewCell

- (void)cellForModel:(id)model;

@end

NS_ASSUME_NONNULL_END

// masonry设置宽高比
/*
 self.productImageView = [[UIImageView alloc] init];
 [self.contentView addSubview:self.productImageView];
 [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.mas_equalTo(16);
     make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(5);
     make.bottom.mas_equalTo(-10);
      //设置宽高比例
     make.width.mas_equalTo(self.productImageView.mas_height).multipliedBy(1);
     //设置优先级
     make.width.height.mas_equalTo(self.contentView).priorityLow();
     make.width.height.lessThanOrEqualTo(self.contentView);
 }];
 
 */
