//
//  CDDetailHeaderView.h
//  MyProject
//
//  Created by 杨 on 23/12/2019.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet QMUIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel; // 总价
@property (weak, nonatomic) IBOutlet UILabel *onePriceLabel; // 单价
@property (weak, nonatomic) IBOutlet UILabel *countLabel; // 数量

- (void)headerForModel:(id)model;

@end

NS_ASSUME_NONNULL_END
